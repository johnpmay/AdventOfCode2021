input := FileTools:-Text:-ReadFile("AoC-2021-18-input.txt" ):

find5nested := proc(input::string,$)
local c, i, count;
    count := 0;
    for i from 1 to length(input) do
        if input[i] = "[" then count += 1; if count=5 then return i; end if;
        elif input[i] = "]" then count -= 1;
        end if;
    end do;
    return 0;
end proc:

PRINT := s->printf(cat(s,"\n"),_rest):

sfreduce := proc(inp::string,$)
local n, pin, regnums, input:=inp, oldinput;

    while oldinput <> input do
        oldinput := input;
    #check
        pin := parse(input);
        if not nops(pin) = 2 then
        error "bad input", input;
        end if;

        PRINT("reducing %s", input);

        n := find5nested(input);
        if n > 0 then
            input := ( sfexplode(input, n) );
            next;
        end if;

        regnums := indets(pin, integer);
        if max(regnums) >= 10 then
            input := ( sfsplit(input) );
            next;
        end if;
    end do;

    return input;

end proc:

sfexplode := proc(input::string, pos::posint:=find5nested(input), $)
local mid, toreplace, toreplacestr;
local lh := input[1..pos-1];
local rh := input[pos..-1]; # starting at the fifth [
local m,n := StringTools:-FirstFromLeft("]", rh);
local toexplode := rh[1..n];
    rh := rh[n+1..-1];
    toexplode := parse(toexplode); # get a list with ints
# righthand element
    n := StringTools:-FirstFromRight(",", lh); # any number will be followed by a ,

    PRINT("exploding %a at position %d", toexplode, pos);

    if n <> 0 then
        if lh[n-1] = "]" then
            while lh[n-1] = "]" do n -= 1 end do;
            mid := lh[n..-1];
            lh := lh[1..n-1]; # number still in lh 
            n := max(StringTools:-FirstFromRight(",", lh),StringTools:-FirstFromRight("[", lh));
        else
            mid := lh[n..-1]; # number still in lh 
            lh := lh[1..n-1]; 
            n := StringTools:-FirstFromRight("[", lh);
        end if;
        toreplace := lh[n+1..-1]; 
        lh := lh[1..n];
        toreplacestr := parse(toreplace) + toexplode[1];
        lh := cat(lh, toreplacestr, mid);
        end if;

    if toreplace = "" then
      error "bug"
    end if;

# lefthand element
    n := StringTools:-FirstFromLeft(",", rh); # any number will be proceded by a ,
    if n <> 0 then
        if rh[n+1] = "[" then      
            while rh[n+1] = "[" do n += 1 end do;
            mid := rh[1..n];
            rh := rh[n+1..-1]; # number still in rh 
            n := min(subs(0=NULL,[StringTools:-FirstFromLeft(",", rh), StringTools:-FirstFromLeft("]", rh)]));
        else
        mid := rh[1..n];
        rh := rh[n+1..-1]; # number still in rh 
        n := StringTools:-FirstFromLeft("]", rh);
    end if;
        toreplace := rh[1..n-1];
        rh := rh[n..-1];
        toreplacestr := parse(toreplace) + toexplode[2];
        rh := cat(mid, toreplacestr, rh);
    end if;

    if toreplace = "" then
      error "bug"
    end if;

    return cat(lh,0,rh);

end proc:


sfsplit := proc(input::string, $)
local i,n,regnum,dig,diglocs;
    # find leftmost - this is slow 
    # a better would be to just sweep to find a two digit number
    dig := map(d->cat("",d), [select(d->d>9,indets(parse(input), 'posint'))[]]);
    diglocs := map(d->StringTools:-Search(d, input), dig);
    i := min[index](diglocs);
    regnum := parse(dig[i]);
    n := diglocs[i];
   
    PRINT("splitting %d at position %d", regnum, n);
    if n > 0 then
        return cat(input[1..n-1], "[", floor(regnum/2), ",",
                   ceil(regnum/2) ,"]", input[n+length(rs)..-1]);
    else
        error "%1 is not in %2", regnum, input;
    end if;
end proc:

sfnorm := proc(input::{list,integer,string},$)
    if type(input, string) then return thisproc(parse(input)); end if;
    if type(input, integer) then return input; end if;
    if nops(input) <> 2 then error "bad sf number", input; end if;
    return thisproc(input[1])*3 + thisproc(input[2])*2;
end proc:

sfadd := proc(s1, s2)
   return cat("[",s1,",",s2,"]");
end proc:

# unit tests
sfexplode( "[[[[[9,8],1],2],3],4]")="[[[[0,9],2],3],4]";
sfexplode( "[7,[6,[5,[4,[3,2]]]]]") = "[7,[6,[5,[7,0]]]]";
sfexplode("[[6,[5,[4,[3,2]]]],1]") = "[[6,[5,[7,0]]],3]";
sfexplode("[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]") = "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]";
sfexplode("[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]")="[[3,[2,[8,0]]],[9,[5,[7,0]]]]";
sfadd("[[[[4,3],4],4],[7,[[8,4],9]]]", "[1,1]");
sfexplode(%);
sfexplode(%);
sfsplit(%);
sfsplit(%);
sfexplode(%)= "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]";
sfreduce("[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]") = "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]";
sfsplit( "[[[[5,11],[13,0]],[[15,14],[14,0]]],[[2,[11,10]],[[0,8],[8,0]]]]") = "[[[[5,[5,6]],[13,0]],[[15,14],[14,0]]],[[2,[11,10]],[[0,8],[8,0]]]]";

PRINT := 'PRINT':
homework := StringTools:-Split(input,"\n"): nops(homework);

sofar := homework[1];
for i from 2 to nops(homework) do
    sofar := sfreduce(sfadd(sofar, homework[i]));
end do:
answer1 := sfnorm(sofar);
answer2 := max([seq(seq(ifelse(i<>j,sfnorm( sfreduce(sfadd(homework[i],homework[j])) ),NULL), j=1..nops(homework)),i=1..nops(homework))]);
