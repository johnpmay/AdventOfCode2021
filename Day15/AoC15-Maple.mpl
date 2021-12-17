input := StringTools:-Trim(FileTools:-Text:-ReadFile("AoC-2021-15-input.txt"));

grid := Matrix(map(s->parse~(StringTools:-Explode(s)),StringTools:-Split(input,"\n"))):

(gridw,gridl) := upperbound(grid);

nbs := proc(i,j,gridsize)
local out := NULL;
    if i < gridsize then
       out := out, [i+1, j];
    end if;
    if j < gridsize then
       out := out, [i, j+1];
    end if;

    if i > 1 then
      out := out, [i-1,j];
    end if;
    if j > 1 then
       out := out, [i, j-1];
    end if;

    return [out];
end proc:

Dijkstra := proc(start, theend, grid)
local pq, costsofar, curr, nb, newcost, pt, gridsize; 
uses priqueue;

gridsize := upperbound(grid)[1];
costsofar := table(sparse=infinity):

initialize(pq):
insert([0,start], pq):
costsofar[start] := 0:

while pq[0] <> 0 do
   curr := extract(pq)[2];
   if curr = theend then
       return costsofar[theend];
   end if;
   nb := nbs(curr[], gridsize);
   for pt in nb do
       newcost := costsofar[curr] + grid[pt[]];
       if newcost < costsofar[pt] then
           costsofar[pt] := newcost;
           insert([-newcost,pt], pq);
       end if;
   end do;
end do:

end proc:

answer1 := Dijkstra([1,1], [gridl,gridw], grid);
# should really do this lazily
inc := a -> (a mod 9) +~ 1;
biggrid:= Matrix([seq([seq((inc@@(i+j-2))(grid),j=1..5)],i=1..5)] );
(biggridw,biggridl) := upperbound(biggrid);
answer2 := Dijkstra([1,1], [biggridl,biggridw], biggrid);


