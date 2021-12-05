input := FileTools:-Text:-ReadFile("AoC-2021-5-input.txt" ):
lines:=map(l->[[parse(l[1])],[parse(l[-1])]],
    {op(map(StringTools:-Split, StringTools:-Split(input,"\n"), "->"))}):

pointcounts1 := table(sparse=0):
pointcounts2 := table(sparse=0):

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

# Visualization

# just the lines
plots:-display(seq(plottools:-line(l[], thickness=0.01),l in lines));

# fancy hotspots
rng := [min,max](entries(pointcounts2,nolist));
colors := [ColorTools:-Color("CVD 8"),ColorTools:-Gradient("CVD 2".."CVD 9", number=rng[2]-rng[1]-2)[]];
epc := [seq(Array(map([lhs], select(p->rhs(p)=i,[entries(pointcounts2,pairs)]))),i=rng[1]..rng[2])]:

plots:-display(
   seq(plottools:-point(epc[i], symbol=solidcircle, color=colors[i], symbolsize=i),i=rng[1]..rng[2] ),
   size=[5000,5000], axes=none, background="Black");

