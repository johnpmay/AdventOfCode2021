input := ImportMatrix("AoC-2021-1-input.txt" ):

scan :=  (v,d)->ifelse(d[2]<0,[v,0],
                        [v, ifelse(v<=d[1], d[2], d[2]+1)]);
                        
rtable_scanblock(input, [], noindex, scan, [-1,-1] )[2]; # part 1 answer

windows := Array([seq(input[i]+input[i+1]+input[i+2],
   i=1..numelems(input)-2)]);
   
rtable_scanblock(windows, [], noindex, scan, [-1,-1])[2]; # part 2 answer
