input := FileTools:-Text:-ReadFile("AoC-2021-16-input.txt" ):

binstr2dec := proc(b) convert(parse(b),decimal,2) end proc:
hex2bits := proc(input) uses StringTools; local tmp := Explode(input); Join(subs([
    "0" = "0000", "1" = "0001", "2" = "0010", "3" = "0011", "4" = "0100",
    "5" = "0101", "6" = "0110", "7" = "0111", "8" = "1000", "9" = "1001",
    "A" = "1010", "B" = "1011", "C" = "1100", "D" = "1101", "E" = "1110", "F" = "1111"],
        tmp),""); end proc:

processpacket := proc( bitinput )
local vertotal, ver, pid, rest, parts, lofbits, subpak, numpaks,
    n, val, theops, thevalue;

    if length(bitinput) < 6 then
        error "error %1 is too short to be valid", bininput;
    end if;

    PRINT("Processing %d bits", length(bitinput));

    ver := binstr2dec(bitinput[1..3]);
    pid := binstr2dec(bitinput[4..6]);
    rest := bitinput[7..];
    vertotal := ver;

    if pid = 4 then # literal
        PRINT("processing literal");
        parts := NULL;
        while rest[1] <> "0" do
            parts := parts, rest[2..5];
            rest := rest[6..];
        end do;
        parts := parts, rest[2..5];

        thevalue := binstr2dec(cat(parts));
        PRINT("literal had %d parts with value=%d", nops([parts]), thevalue);
        rest := rest[6..];
        PRINT("after literal %d bits left", length(rest));
    else
        PRINT("processing operator ID=%d", pid);
        theops := NULL;
        if rest[1] = "0" then
            
            lofbits := binstr2dec(rest[2..16]);
            PRINT("type-0 operator with %d bits of subpackets", lofbits);
            rest := rest[17..];
            subpak := rest[1..lofbits];
            while length(subpak) > 6 do
                (n, val, subpak) := thisproc(subpak);
                vertotal += n;
                theops := theops, val;
            end do;
            rest := rest[lofbits+1..];
            PRINT("after type-0 %d bits left", length(rest));
        else        
            numpaks := binstr2dec(rest[2..12]);
            PRINT("type-1 operator with %d subpackets",numpaks);
            rest := rest[13..];
            to numpaks do
                (n, val, rest) := thisproc(rest);
                theops := theops, val;
                vertotal += n; 
            end do;
            PRINT("after type-1 %d bits left", length(rest));
        end if;
        if pid = 0 then thevalue := `+`(theops);
        elif pid = 1 then thevalue := `*`(theops);
        elif pid = 2 then thevalue := min(theops);
        elif pid = 3 then thevalue := max(theops);
        elif pid = 5 then thevalue := ifelse( theops[1] > theops[2], 1, 0);
        elif pid = 6 then thevalue := ifelse( theops[1] < theops[2], 1, 0);
        elif pid = 7 then thevalue := ifelse( theops[1] = theops[2], 1, 0);
        else error "bad operator pid";
        end if;
    end if;

    PRINT("returning with %d bits left", length(rest));
    return vertotal, thevalue, rest;

end proc:

# uncomment for verbose output
#PRINT := s->printf(cat(s,"\n"), _rest);

(*
# unit tests
processpacket( hex2bits("C200B40A82") )[2]=3;
processpacket( hex2bits("04005AC33890") )[2]=54;
processpacket( hex2bits("880086C3E88112"))[2]=7;
processpacket( hex2bits( "CE00C43D881120" ) )[2]=9;
processpacket( hex2bits( "D8005AC2A8F0" ))[2]=1;
processpacket( hex2bits("F600BC2D8F") )[2]=0;
processpacket( hex2bits("9C005AC2F8F0") )[2] = 0;
processpacket( hex2bits("9C0141080250320F1802104A08"))[2] = 1;
*)

# answers
(answer1, answer2, fluff) := processpacket( hex2bits( input ) ):
answer1;
answer2;