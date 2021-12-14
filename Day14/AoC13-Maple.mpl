input := FileTools:-Text:-ReadFile("AoC-2021-14-input.txt" ):

split := StringTools:-Split(input,"\n"):
polymer := split[1];
rules := map(s->StringTools:-Split(s)[[1,3]], split[3..-1]):
rulestable := table(map(`=`@op, rules)):

init_rules := map(r->[StringTools:-SearchAll(r[1],polymer)], rules):
init_rules := rhs~(sort( map(r->seq(s=rhs(r), s in lhs(r)),
    (remove(r->lhs(r)=[], zip(`=`, init_rules, rules)))) )):

# initial state
paircount := table(sparse=0):
for c in init_rules do
    paircount[c[1]] += 1;
end do:

for i to 40 do
    update := indices(paircount, 'pairs');
    paircount := table(sparse=0):
    lettercount := table(sparse=0):
    for u in update do
        c := [lhs(u), rulestable[lhs(u)]];
        paircount[ cat(c[1][1],c[2]) ] += rhs(u);
        paircount[ cat(c[2],c[1][2]) ] += rhs(u);
        lettercount[ c[1][1] ] += rhs(u);
        lettercount[ c[1][2] ] += rhs(u);
        lettercount[ c[2] ] += 2*rhs(u);
    end do:
    lettercount["B"] += 1;
    lettercount["N"] += 1;
    t:=[entries(lettercount, 'nolist')];
    if i = 10 or i = 40 then
        print( i=(t[max[index](t)] - t[min[index](t)]) / 2);
    end if;
end do:




