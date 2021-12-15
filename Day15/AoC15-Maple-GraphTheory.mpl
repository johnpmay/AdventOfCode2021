input := StringTools:-Trim(FileTools:-Text:-ReadFile("AoC-2021-15-input.txt"));
grid := Matrix(map(s->parse~(StringTools:-Explode(s)),StringTools:-Split(input,"\n"))):
(gridw,gridl) := upperbound(grid);

inc := a -> (a mod 9) +~ 1;
gb:= Matrix([seq([seq((inc@@(i+j-2))(grid),j=1..5)],i=1..5)] );
(gbw,gbl) := upperbound(gb);

nbs := proc(i,j,gridsize)
local out := NULL;
    if i < gridsize then out := out, [i+1, j]; end if;
    if j < gridsize then out := out, [i, j+1]; end if;
    if i > 1 then out := out, [i-1,j]; end if;
    if j > 1 then out := out, [i, j-1]; end if;
    return [out];
end proc:

with(GraphTheory):
G := MakeWeighted(MakeDirected(SpecialGraphs:-GridGraph(gridl,gridw)));

for e in Edges(G) do
    SetEdgeWeight(G, e, grid[parse(e[2])]);
end do:

DijkstrasAlgorithm(G, "1,1", cat("",gridl,",",gridw))[2];
BG := MakeWeighted(MakeDirected(SpecialGraphs:-GridGraph(gbl,gbw)));

W := WeightMatrix(BG, copy=false);

for i from 1 to gbl do for j from 1 to gbw do
       a := j + (i-1)*(gbw);
       for n in nbs(i,j,gbw) do
           b := n[2] + (n[1]-1)*gbw; W[b,a] := gb[i,j];
       end do;
end do; end do:

answer2 := DijkstrasAlgorithm(BG, "1,1", cat("",gbl,",",gbw))[2];

