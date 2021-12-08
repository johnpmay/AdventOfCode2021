input := FileTools:-Text:-ReadFile("AoC-2021-8-input.txt" ):

lines := subs(""=NULL,(op@StringTools:-Split)~(StringTools:-Split(input, "\n"),"|"));

# part 1, just count the 1, 4, 7, and 8s
total := 0:
for i from 2 to nops(lines) by 2 do
    tal := table(sparse=0,Statistics:-Tally(map(length, StringTools:-Split(lines[i]))));
    total := total + tal[2] + tal[3] + tal[4] + tal[7];
end do:

answer1 := total;

# part 2

Decode := proc( code, output )

    local decode := table();
    # inputs are sets of letters so we can use set operations on everything
    local displays := { ({op@StringTools:-Explode})~(
        StringTools:-Split(StringTools:-Trim(code)," "))[] };

    # easy cases - unique lengths
    decode["1"] := select(d->nops(d)=2, displays)[1];
    decode["4"] := select(d->nops(d)=4, displays)[1];
    decode["7"] := select(d->nops(d)=3, displays)[1];
    decode["8"] := select(d->nops(d)=7, displays)[1];

    local sixes := select(d->nops(d)=6, displays);
    local fives := select(d->nops(d)=5, displays);

    # length six 0, 6, 9
    # 6 is disjoint from 1
    decode["6"] := select(d->not decode["1"] subset d, sixes)[1];
    # 9 contains 4
    decode["9"] := select(d->decode["4"] subset d, sixes)[1];
    # otherwise 0
    decode["0"] := op(1,sixes minus {decode["6"], decode["9"]});

    # length five 2,3,5
    # 3 contains 1
    decode["3"] := select(d->decode["1"] subset d, fives)[1];
    fives := fives minus {decode["3"]};
    # 5 is contained in 9 (so is 3 so we removed it first)
    decode["5"] := select(d->d subset decode["9"], fives)[1];
    # otherwise 2
    decode["2"] := op(1,fives minus {decode["5"]});

    local decodsubs := sort((rhs=lhs)~([entries(decode,pairs)]));

    local outs := ({op@StringTools:-Explode})~(
        StringTools:-Split(StringTools:-Trim(output)," "));

    return parse(StringTools:-Join(subs(decodsubs, outs),""));

end proc: # Decode

answer2 := add( Decode(lines[i], lines[i+1]), i=1..nops(lines), 2);
