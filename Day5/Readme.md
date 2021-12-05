# Day 5

Rich datastructures in Maple make the main solution pretty easy

```pointcounts1 := table(sparse=0): pointcounts2 := table(sparse=0):

for l in lines do
    step := signum~(l[2] - l[1]);
    ls := l[1];
    pointcounts2[op(ls)] += 1;
    if 0 in step then        
        pointcounts1[op(ls)] += 1;
    end if;
    while ls <> l[2] do
        ls := ls + step;
        pointcounts2[op(ls)] += 1;
        if 0 in step then        
            pointcounts1[op(ls)] += 1;
        end if;
    end do;
end do:

answer1:=nops(select(i->i>1,[entries(pointcounts1, nolist)]));
answer2:=nops(select(i->i>1,[entries(pointcounts2, nolist)]));
```
but a pretty visualization in necessary:

![hot spots visualization](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day5/AOC5-vis-1600.png)
