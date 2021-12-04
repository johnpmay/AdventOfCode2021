inputfile := "AOC4-input.txt":

# parse input
input := subs(""=NULL,StringTools:-Split(
        FileTools:-Text:-ReadFile(inputfile), "\n\n")):
numbers := [parse(input[1])]: # list of numbers to "call"
# list of bingo boards stored as square lists of lists
boards := [seq(map(s->map(parse, StringTools:-Split(s)),
    input[(i-1)*5+2..(i*5+1)]), i=1..ceil( nops(input[2..]) / 5 ))]:

# helper to check for row or column bingos marked with the symbol X
checkbingo := b->ormap(r->numboccur(X,r)=5,b) or
     `or`(seq(numboccur(X,b[..,i])=5,i=1..5)):

answer1 := -1:
for n in numbers while answer1<0 do
    boards := subs(n=X, boards); # mark all the boards at once
    for b in boards while answer1<0 do
        if checkbingo(b) then
            answer1 := add(subs(X=0,map(op,b)))*n;
        end if;
    end do;
end do:
answer1;

for n in numbers while not checkbingo(boards[1]) do
    if nops(boards) > 1 then
        boards := remove(checkbingo, subs(n=X, boards));
    else
        boards := subs(n=X, boards);
        answer2 := add(subs(X=0,map(op,boards[1])))*n;
    end if;
end do:
answer2;
