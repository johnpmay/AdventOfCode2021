# Day 9

https://adventofcode.com/2021/day/9

## Maple

The first problem was finding the low points on a grid of values 0-9, and
my first instict was to pad the border with 9's to avoid all the special
case logic on the boundries. Then finding the low points is a simple linear sweep

    lowpoints := NULL:
    risklevel := 0:
    for i from 2 to gridl+1 do
        for j from 2 to gridw+1 do
            if      grid[i][j] < grid[i-1][j]
                and grid[i][j] < grid[i+1][j]
                and grid[i][j] < grid[i][j-1]
                and grid[i][j] < grid[i][j+1]
            then
                lowpoints := lowpoints, [i,j];
                risklevel := risklevel + grid[i][j]+1;
            end if;
        end do;
    end do:
    answer1 := risklevel;

The second part was to count the sizes of all the basins around the low points.
I wasted time on stupid things when I should have done recursion from the beginning.
In retrospect maybe making a `neighbors` helper function would have made this code a
little easier and avoided the necessity of  padding the grid. We needed to track all
the gridpoints that had already been visited, I did that with a sparse global table `counted`.

    counted := table(sparse=0):
    basinsize := proc( xyv )
    global grid, counted;
    local nb, x, y, v;

        x, y, v := op(xyv);
        if v = 9 or counted[xyv] <> 0 then
            return 0;
        end if;

        nb := [[x, y-1], [x, y+1], [x-1, y], [x+1,y]];
        nb := remove( n->(min(n)<2 or n[1]>gridl+2 or n[2]>gridw+2), nb);
        nb := map(n->[n[1], n[2], grid[n[1]][n[2]]], nb);
        
        counted[ xyv ] := 1;

        if nb = [] then
            return 1;
        else
            return add(map(thisproc, nb))+1;
        end if;
    end proc:

    bs := map(l->basinsize([l[], grid[l[1]][l[2]]]), [lowpoints]):
    answer2 := mul( sort(bs)[-3..-1] );


## Scratch

This one is slightly tricky because you have to manage your own "local" variables
in a stack when using recursion in Scratch.

To track visited nodes in part 2 I used a 103^2 elment list as a simple hash table
so it will not work for grids larger than 100x100 without modificaton.

To get the largest three basins, I implemented a really janky three element heap.

https://scratch.mit.edu/projects/614458781/

![scratch blocks](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day9/Scratch%20Screen%20Shot%20Day%209.png)
