# Day 5

Rich datastructures in Maple make the main solution pretty easy
```
pointcounts1 := table(sparse=0): pointcounts2 := table(sparse=0):

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

I swore that I was too hard to do in Scratch, but then I stepped up to the challenge, realizing that coordinate pairs
in [0..999, 0..999] are pretty easily encoded as 6 digit numbers XXXYYY. Of course, that still left how to track which
points were on lines so as to later find intersections.  For my first solution, I just put points in a list as they were visited
and then added the intersections to a second list.  But, I had to search in those lists A LOT and they get really BIG. So it took
20 minutes to run. To make the wait bearable, I added a pen-based visualization. https://scratch.mit.edu/projects/613362825/

![Scratch Screen Shot](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day5/Scratch_The_Slow_Way.jpeg)

So, I decided to make a table, as in Maple, but it was too hard to do it sparse, so I made a dense table to hold all 1,000,000 
points on the grid.  Scratch limits lists to 200,000 elements, so I made it using 10 lists of size 100,000.  For each point I 
used the first digit to choose a table, and the other 5 to choose an index. It's ugly but takes only about 20 seconds to run.
Next time I might try a real hash table, in theory I could have gotten away with fewer lists here.

![Many Scratch Blocks](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day5/Advent%20of%20Code%202021%20Day%205%20-%20Scratch%20with%20a%20hash.png)
