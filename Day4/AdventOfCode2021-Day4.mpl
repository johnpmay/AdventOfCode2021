inputfile := "AOC4-input.txt":
input := StringTools:-Split(FileTools:-Text:-ReadFile(inputfile), "\n"):
numbers := [parse(input[1])]:
input := map(StringTools:-Trim@StringTools:-Squeeze,input[3..-1]):
numboards := ceil( nops(input) / 6 );
theboards := [seq(1..numboards)]:

# create board and mark arrays for each bingo board
for i to numboards do
    tmp := map(s->map(parse, StringTools:-Split(s)),input[1..5]);
    boards[i] := Array(tmp,datatype=integer);
    marks[i] := Array(1..5, 1..5, 0, datatype=integer[1]);
    if i <> numboards then
        input := input[7..-1];
    else
        input := [];
    end if;
end do:

# find the location of n on each board and mark it
drawnumber := proc(n)
global boards, marks, theboards;
local i, loc;
    for i in theboards do
        if member(n, boards[i], 'loc') then
            marks[i][loc] := 1;
        end if;
    end do;
    return NULL;
end proc:

# check if board i has a bingo marked
checkbingo :=proc(i)
global marks;
    if max(ArrayTools:-AddAlongDimension(marks[i], 1)) = 5 then
        return true;
    elif max(ArrayTools:-AddAlongDimension(marks[i], 2)) = 5 then
        return true;
    else
        return false;
    end if;
end proc:

# first problem - find the board that will win FIRST
answer1 := FAIL:
for j to nops(numbers) while answer1 = FAIL do
    n := numbers[j];
    drawnumber(n);
    for i to numboards do
        if checkbingo(i) then
            answer1 := add(boards[i]-boards[i]*marks[i])*n;
            break;
        end if;
    end do;
end do:
answer1;

# second problem - find the board that will win LAST
answer2 := FAIL:
numbingos := 0:
for j to nops(numbers) while answer2 = FAIL do
    n := numbers[j];
    drawnumber(n);
    for i in theboards do
        if checkbingo(i) then
            if nops(theboards) = 1 then
                answer2 := add(boards[i]-boards[i]*marks[i])*n;
            end if;
            theboards := subs(i=NULL, theboards); 
        end if;
    end do;
end do:
answer2;
