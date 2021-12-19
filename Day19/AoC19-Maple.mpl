input := FileTools:-Text:-ReadFile("AoC-2021-19-input.txt" ):

with(StringTools):
scanners := map(l->[parse]~(l[2..-1]),
     map(Split,Split(SubstituteAll(input, "\n\n", "X"),"X"),"\n")):

truelocs := table();
truelocs[1] := scanners[1]; # base 0

sunknown := [seq(2..nops(scanners))];
knownscans := [1=[0,0,0]];

dist := (v,u) -> add((v[i]-u[i])^2,i=1..3):

# used to generate equations
M := Matrix(3,3,(i,j)->a[i,j]):
A := <a[0,1], a[0,2], a[0,3]>:

for k1 to nops(scanners)-1 do

    # find a scanner that overlaps with a known scanner 
    for j1 from 1 to nops(knownscans) do
        sn1 := lhs(knownscans[j1]);
        scan0 := truelocs[sn1];

        for i1 from 1 to nops(sunknown) do
            # compute all pairwise distances
                sn2 := sunknown[i1];
                scan1 := scanners[sn2];
                n0 := nops(scan0); n1 := nops(scan1);
                # building pairs"
                M0 := Matrix([seq([seq(dist(scan0[i],scan0[j]),j=1..n0)],i=1..n0)]):
                M1 := Matrix([seq([seq(dist(scan1[i],scan1[j]),j=1..n1)],i=1..n1)]):

            ints01 := {entries(M0,'nolist')} intersect {entries(M1,'nolist')} minus {0};

            if nops(ints01) < 50 then
#                printf("scanner %d can not overlap  scanner %d -- only %d common pairs\n", sn1, sn2, nops(ints01) );
                next;
            end if; # at least 66 needed for 12 in common

                # looking up pair from their common distances
            pairs0 := NULL: pairs1 := NULL:
            for i from 1 to nops(ints01) do
                member(ints01[i], M0, 'loc0'); pairs0 := pairs0, [loc0];
                member(ints01[i], M1, 'loc1'); pairs1 := pairs1, [loc1];nu
            end do:
            pairs0 := [pairs0];
            pairs1 := [pairs1];

            # these are the overlapping sets of beacons
            o0 := [seq](ifelse(numboccur(pairs0,i)=11,i,NULL),i=1..n0);
            o1 := [seq](ifelse(numboccur(pairs1,i)=11,i,NULL),i=1..n1);
            if nops(o0) <> 12 then
                #printf("found only %d=%d overlaps between %d and %d skipping\n", nops(o0), nops(o1), sn1, sn2);
                next;
            end if;

            # determine the pairings
            pot01matches := table(sparse={o1[]});

            for i from 1 to nops(pairs0) do
                if pairs0[i][1] in o0 and pairs0[i][2] in o0 then # check o2 too?
                pot01matches[pairs0[i][1]] := pot01matches[pairs0[i][1]] intersect {pairs1[i][]};
                pot01matches[pairs0[i][2]] := pot01matches[pairs0[i][2]] intersect {pairs1[i][]};
                end if;
            end do;

            if {} in {entries(pot01matches,'nolist')} then
                printf("found a contradiction in the potential pairings\n");
                next;
            end if;

            matches01 := map(p->lhs(p)=rhs(p)[], [entries(pot01matches,'pairs')]);

            # use symbolic computation to build the equations to solve for the rotation
            # and translation
            eqs := {seq(seq((M . Vector(scan1[rhs(matches01[k])]) + A)[j]
                = Vector(scan0[lhs(matches01[k])])[j], j=1..3),k=1..4)};
            sol := solve( eqs );

            Mo := eval(M, sol);
            a0 := eval(<a[0,1], a[0,2], a[0,3]>, sol);

            scan1 := [seq(convert(Mo . Vector(scan1[i]) + a0,list), i=1..nops(scan1))];
            knownscans := [knownscans[], sn2=convert(a0,list)];
            sunknown := subsop(i1=NULL, sunknown); # remove this scan from the unknowns
            truelocs[sn2] := scan1;
            break;

        end do;
    end do;
end do;

ASSERT(nops(knownscans) = nops(scanners));
answer1 := nops( map(op, {entries}(truelocs,'nolist') ) );

# compute the Manhatten distance between scanners
mdist := (u,v) -> add(abs(u[i]-v[i]),i=1..3):
scannerlocs := map(rhs, knownscans);
answer2 := max( seq(seq(mdist(scannerlocs[i],scannerlocs[j]),j=i+1..nops(scannerlocs)),i=1..nops(scannerlocs)));

