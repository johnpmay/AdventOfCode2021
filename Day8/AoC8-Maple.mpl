input := FileTools:-Text:-ReadFile("AoC-2021-8-input.txt" ):

lines := subs(""=NULL,(op@StringTools:-Split)~(StringTools:-Split(input, "\n"),"|"));

# part 1, just count the 1, 4, 7, and 8s
total := 0:
for i from 2 to nops(lines) by 2 do
    tal := table(sparse=0,Statistics:-Tally(map(length, StringTools:-Split(lines[i]))));
    total := total + tal[2] + tal[3] + tal[4] + tal[7];
end do:

answer1 := total;

# part 2

sortstring := s->StringTools:-Join( sort( StringTools:-Explode(s) ), "");
lookups := ["abcefg"="0", "acdeg"="2", "acdfg"="3", "abdfg"="5", "abdefg"="6", "abcdfg"="9"];
alphab := {seq(j,j in "abcdefg")};

Decode := proc( code, output )
local j, displays, cypher, i, decoded, w, wl, l, wc, n;

    displays := sort( StringTools:-Split(StringTools:-Trim(code)," "), length );

    cypher := table([seq(i={seq(j,j in "abcdefg")},i in "abcdefg")]):
    decoded := table();

    for w in displays do
        wl := {seq(i, i in w)};
        if length(w) = 2 and not assigned(decoded["1"]) then # 1
            decoded["1"] := sortstring(w);
            # may be
            cypher["c"] := cypher["c"] intersect wl;
            cypher["f"] := cypher["f"] intersect wl;
            # can't be
            for l in "abdeg" do
                cypher[l] := cypher[l] minus wl;
            end do;
        elif length(w) = 3 and not assigned(decoded["7"])then # 7
            decoded["7"] := sortstring(w);
            cypher["c"] := cypher["c"] intersect {seq(i, i in w)};
            cypher["f"] := cypher["f"] intersect {seq(i, i in w)};
            cypher["a"] := cypher["a"] intersect {seq(i, i in w)};
            if assigned(decoded["2"]) then
                cypher["a"] := cypher["a"] intersect {seq(i, i in w)} minus cypher["c"];
            end if;
            if nops( cypher["a"] ) = 1 then
                for l in alphab minus {"a"} do
                    cypher[l] := cypher[l] minus cypher["a"];
                end do;
            end if;
            for l in "bdeg" do
                cypher[l] := cypher[l] minus wl;
            end do;
        elif length(w) = 4 and not assigned(decoded["4"])then # 4
            decoded["4"] := sortstring(w);
            cypher["b"] := cypher["b"] intersect {seq(i, i in w)};
            cypher["d"] := cypher["d"] intersect {seq(i, i in w)};
            cypher["c"] := cypher["c"] intersect {seq(i, i in w)};
            cypher["f"] := cypher["f"] intersect {seq(i, i in w)};
            for l in "aeg" do
                cypher[l] := cypher[l] minus wl;
            end do;
        elif length(w) = 7 and not assigned(decoded["8"]) then # 8
            decoded["8"] := sortstring(w);
            cypher["b"] := cypher["b"] intersect {seq(i, i in w)};
            cypher["d"] := cypher["d"] intersect {seq(i, i in w)};
            cypher["c"] := cypher["c"] intersect {seq(i, i in w)};
            cypher["f"] := cypher["f"] intersect {seq(i, i in w)};
        elif length(w) = 6 then # 0, 6, 9 missing letters must be c,d,e
            wc := alphab minus wl;
            for l in "abf" do
                cypher[l] := cypher[l] minus wc;
            end do; 
        elif length(w) = 5 then # 2, 3, 5 missing letters must be b,c,e,f
            wc := alphab minus wl;
            for l in "adg" do
                cypher[l] := cypher[l] minus wc;
            end do; 
        end if;
    end do:
    
    for l in alphab do
        if nops(cypher[l]) = 1 then
            for n in alphab minus {l} do
                cypher[n] := cypher[n] minus cypher[l];
            end do;
        end if;
    end do;

    for l in alphab do
        if nops(cypher[l]) <> 1 then
            error "need more!";
        end if;
        cypher[l] := op(cypher[l]);
    end do:

    cypher := sort((rhs=lhs)~([entries(cypher,pairs)]));
    decoded := sort((rhs=lhs)~([entries(decoded,pairs)]));

    tmp := map(sortstring, StringTools:-Split(output," "));
    tmp := map2(subs, decoded, tmp);
    tmp := (StringTools:-Join([seq]( subs(lookups, StringTools:-Join(sort( subs(cypher, convert(w,list)) ),"")), w in tmp), "") );

    return parse(tmp);

end proc:

answer2 := add( Decode(lines[i], lines[i+1]), i=1..nops(lines), 2);
