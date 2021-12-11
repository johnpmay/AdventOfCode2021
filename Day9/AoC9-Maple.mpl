input := FileTools:-Text:-ReadFile("AoC-2021-9-input.txt" ):

ogrid := ((parse~)@StringTools:-Explode)~(subs(""=NULL,StringTools:-Split(input))):
gridw := nops(ogrid[1]);
gridl := nops(ogrid);
grid := [ [ 9 $ (gridw+2) ], map(l->[9,l[],9], ogrid)[],  [ 9 $ (gridw+2) ] ]:

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

counted := table(sparse=0):
basinsize := proc( input )
global grid, counted;
local nb, x, y, v;

    x, y, v := op(input);

    if v = 9 or counted[input] <> 0 then
        return 0;
    end if;

    nb := [[x, y-1], [x, y+1], [x-1, y], [x+1,y]];
    nb := remove( n->(min(n)<2 or n[1]>gridl+2 or n[2]>gridw+2), nb);
    nb := map(n->[n[1], n[2], grid[n[1]][n[2]]], nb);
    #nb := remove(n->n[3]=9 or n[3] < v, nb); # for non-9 bounded basins

    counted[ input ] := 1;

    if nb = [] then
        return 1;
    else
        return add(map(thisproc, nb))+1;
    end if;
end proc:

bs := map(l->basinsize([l[], grid[l[1]][l[2]]]), [lowpoints]):
answer2 := mul( sort(bs)[-3..-1] );
