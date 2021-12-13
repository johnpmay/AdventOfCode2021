input := FileTools:-Text:-ReadFile("AoC-2021-13-input.txt" ):

testinput := "6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5";

split:=StringTools:-Split(input, "\n"):
member("", split, 'loc'); loc;

coords := split[1..loc-1]:
folds := split[loc+1..-1];
coords := {map(p->[parse(p)], coords)[]}:
folds := parse~(map(s->StringTools:-SubstituteAll(s, "fold along ", ""), folds));

vis := coords->plots:-display(plottools:-point(map(c->[c[1],-c[2]], [coords[]]),
    symbol=solidbox, symbolsize=20), axes=boxed, scaling=constrained):

newcoords := coords:
for f in folds do
    if lhs(f) = 'y' then
        (c1,c2) := selectremove(p->p[2]<rhs(f), newcoords);
        c2 := map(p->[p[1], 2*rhs(f)-p[2]], c2);
        newcoords := c1 union c2;
    else
        (c1,c2) := selectremove(p->p[1]<rhs(f), newcoords);
        c2 := map(p->[2*rhs(f)-p[1], p[2]], c2);
        newcoords := c1 union c2;
    end if;
    if f = folds[1] then
        answer1 := nops(newcoords);
    end if;
end do:
answer1;
vis(newcoords);
