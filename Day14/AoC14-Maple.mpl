input := FileTools:-Text:-ReadFile("AoC-2021-14-input.txt" ):

split := StringTools:-Split(input,"\n"):
polymer := split[1];
rules := table(map(`=`@op,
    map(s->StringTools:-Split(s)[[1,3]], split[3..-1]))):

# initial count
paircount := table(sparse=0):
for i to length(polymer)-1 do
   paircount[polymer[i..i+1]] += 1;
end do:

for i to 40 do
    update := indices(paircount, 'pairs');
    paircount := table(sparse=0):
    lettercount := table(sparse=0):
    for u in update do
        b := lhs(u); c := rules[lhs(u)];
        paircount[ cat(b[1],c) ] += rhs(u);
        paircount[ cat(c,b[2]) ] += rhs(u);
        lettercount[ b[1] ] += rhs(u);
        lettercount[ b[2] ] += rhs(u);
        lettercount[ c ] += 2*rhs(u);
    end do:
    lettercount[polymer[1]] += 1; lettercount[polymer[-1]] += 1;
    if i = 10 or i = 40 then
        t:=[entries(lettercount, 'nolist')];
        print( i=(t[max[index](t)] - t[min[index](t)]) / 2);
    end if;
end do:
