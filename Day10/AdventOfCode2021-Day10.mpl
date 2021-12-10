lines := StringTools:-Split(input):
matchlookup := table( [ "]"="[", "}"="{", ">"="<", ")"="(",
    "["="]", "{"="}", "<"=">", "("=")" ] );
scores :=  table( [ "]"=57, "}"=1197, ">"=25137, ")"=3 ] ):
scores2 := table( ["("=1, "["=2, "{"=3, "<"=4] ):

points := 0:
badlines := NULL:
for j to nops(lines) do

    bracestack := DEQueue();
    for i to length(lines[j]) do    
        if lines[j][i] in { "[", "{", "<", "(" } then       
            push_back(bracestack, lines[j][i]);
        elif lines[j][i] in { "]", "}", ">", ")" } then
            c := pop_back(bracestack);       
            if not c = matchlookup[lines[j][i]] then
                printf("Expected %a, but found %a instead.\n",
                    matchlookup[c], lines[j][i] );
                points += scores[lines[j][i]];
                badlines := badlines, j;
                break;
            end if;
        end if;
    end do;

    acscore[j] := 0;
    while not empty(bracestack) do
        c := pop_back(bracestack);
        acscore[j] := 5*acscore[j] + scores2[c];
    end do;
end do:

answer1 := points;
answer2 := round(Statistics:-Median([seq( acscore[i],
    i in ({ seq(1..nops(lines)) } minus {badlines}))] ));



