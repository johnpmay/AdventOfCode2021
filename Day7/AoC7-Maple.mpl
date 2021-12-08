input := FileTools:-Text:-ReadFile("AoC-2021-7-input.txt" ):

pos := parse~(StringTools:-Split(input,",")):
answer1 := min(seq(add(abs~(pos-~i)),i=min(pos)..max(pos)));
answer2 := min(seq( 
    add(((pos[i]-j)^2+abs(pos[i]-j))/2, i=1..nops(pos)),
        j=min(pos)..max(pos)));
