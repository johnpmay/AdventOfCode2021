# Day 8

https://adventofcode.com/2021/day/8

So much to read on this problem. So many simplifying assumptions if you read it correctly.

## Maple

I jumped into decoding right away, only to later realize the first part
just wanted a super simple count of strings of a given length. Oops.

    # part 1, just count the 1, 4, 7, and 8s
    total := 0:
    for i from 2 to nops(lines) by 2 do
        tal := table(sparse=0,Statistics:-Tally(map(length, StringTools:-Split(lines[i]))));
        total := total + tal[2] + tal[3] + tal[4] + tal[7];
    end do:
    
    answer1 := total;

Fortunately, the second part wanted the decoding. I built up a super messy
loop of lots of conditionals that did the job. Later, I realized that a very
simple switch on length plus some set theory was a very clean solution.

    Decode := proc( display, output )
        key := table();
        disp := { ({op@StringTools:-Explode})~(
            StringTools:-Split(StringTools:-Trim(display)," "))[] };
    
        key["1"] := select(d->nops(d)=2, disp)[];
        key["4"] := select(d->nops(d)=4, disp)[];
        key["7"] := select(d->nops(d)=3, disp)[];
        key["8"] := select(d->nops(d)=7, disp)[];
        key["6"] := select(d->nops(d)=6 and not key["1"] subset d, disp)[];
        key["9"] := select(d->nops(d)=6 and key["4"] subset d, disp)[];
        key["0"] := select(d->nops(d)=6 and d<>key["6"] and d<>key["9"], disp)[];   
        key["3"] := select(d->nops(d)=5 and key["1"] subset d, disp)[];
        disp := disp minus {seq(key[l], l in "01346789")};
        key["5"] := select(d->d subset key["9"], disp)[];
        key["2"] := op(disp minus {key["5"]});
   
        keysubs := sort((rhs=lhs)~([entries(key,pairs)]));
        outs := ({op@StringTools:-Explode})~(
            StringTools:-Split(StringTools:-Trim(output)," "));
        return parse(StringTools:-Join(subs(keysubs, outs),""));
    end proc:


## Scratch

I refined the decoding set theory down to just subset containment that allowed me
to implement "string equiv" and "string contains" helper functions that ignored string
order the < () contatins () ? > block is the real hero here. Then it's just a long switch.

https://scratch.mit.edu/projects/613910337/

![Scratch Blocks](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day8/AoC2021-ScratchDay8.png)
