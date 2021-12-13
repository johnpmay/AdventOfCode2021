#sample
tinput := "5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526";

#toy
tinput := "11111
19991
19191
19991
11111";

input := FileTools:-Text:-ReadFile("AoC-2021-11-input.txt" ):

ogrid := map((parse~),StringTools:-Explode~(StringTools:-Split(input)));
gridw := nops(ogrid[1]); gridl := nops(ogrid);

neighbors := proc(pt) # include diagonals
local x, y, out;
global gridw, gridl;
    out := NULL;
    (x,y) := pt[];
    if x > 1 then
        out := out, [x-1, y];
        if y > 1 then
            out := out, [x-1, y-1];
        end if;
    end if;
    if y > 1 then
        out := out, [x, y-1];
        if x< gridw then
           out := out, [x+1, y-1];
        end if;
     end if;
    if x < gridw then
        out := out, [x+1, y];
        if y < gridl then
           out := out, [x+1, y+1];
        end if;
    end if;
    if y < gridl then
        out := out, [x, y+1];
        if x > 1 then
           out := out, [x-1, y+1];
        end if;
     end if;
    return [out];
end proc:
    
flash := proc(x,y)
local n, nb := neighbors([x,y]);
global grid, flashed;
    if flashed[x,y] <> 0 then
    # flashed is a table to track that we flashed only once
        return;
    end if;
    flashed[x,y] := 1;
    for n in nb do
    # increment neighbors and maybe trigger their flashes 
        grid[n[]] += 1;
        if grid[n[]] > 9 then
            flash(n[]);
        end if;
     end do;
end proc: # flash
totalflashes := 0;
grid := Array(ogrid);

for dd from 1 to 1000 while add(grid) <> 0 do
    grid := grid +~ 1; # increment grid
    flashed := table(sparse=0); # clear flash tracking table
    # do the flashes - flash may trigger flashes earlier too
    for i from 1 to gridw do
        for j from 1 to gridl do
            if grid[i,j] > 9 then
                flash(i,j);
            end if;
        end do;
    end do;
    # count and reset flashed
    for i from 1 to gridw do
        for j from 1 to gridl do
            if grid[i,j] > 9 then
                grid[i,j] := 0;
                if i <= 100 then
                    totalflashes+=1;
                end if;
            end if;
        end do;
    end do;

end do: # days

answer1 := totalflashes;
answer2 := (dd-1);


