toy_input := "start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end":

toy2_input:="dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc":

sample_input := "fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW":

input := FileTools:-Text:-ReadFile("AoC-2021-12-input.txt" ):

nodes := map(s->{StringTools:-Split(s,"-")[]}, StringTools:-Split(input)):
G := GraphTheory:-Graph( {nodes[]} );
small := select(StringTools:-IsLower,{map(op, nodes)[]}) minus {"end"};

numpaths := proc(a, s2:=FAIL, visited_s2:=false,
                 excluding:={"start"}, path:=[] )
global G, small;
local newex, newvs2;

    if a = "end" then
       if s2<>FAIL and numboccur(path, s2) <> 2 then
          return 0;
       end if;
#       print([path[],"end"]);
       return 1;
    end if;

    local nb := {GraphTheory:-Neighborhood(G, a)[]} minus excluding;
    if a = s2 and visited_s2 = false then
         newex := excluding;
         newvs2 := true;
    elif a in small then
         newex := excluding union {a};
         newvs2 := visited_s2;
    else
         newex := excluding;
         newvs2 := visited_s2;
    end if;

    return add(numpaths(i, s2, newvs2, newex, [path[],a]), i in nb);

 end proc:

answer1 := numpaths("start");
answer2 := answer1 + add(numpaths("start", pp), pp in small minus {"start"});

