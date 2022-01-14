input := FileTools:-Text:-ReadFile("AoC-2021-20-input.txt"):
with(StringTools):

split:=Split(Trim(input), "\n"):
code := split[1]; length(code);

bin2dec := proc(s)
     if length(s) <> 9 then error "length of %1 is not 9, it is %2", s, length(s); end if;
     local l := Explode(s);
     add(ifelse(l[i]=".", 0, ifelse(l[i]="#", 1, X))*2^(9-i), i=1..9);
end proc:

bin2dec("...#...#.") = 34; code[34+1];

image := split[3..-1]: {Explode(Join(image,""))[]};

iwidth := length(image[1]);
ilength := nops(image);
ipad := 2;
p := code[bin2dec(cat(code[1]$9))+1];

image := [ cat(p$(iwidth+2*ipad))$ipad,
    seq(cat(p$ipad,image[i],p$ipad), i=1..iwidth),
    cat(p$(iwidth+2*ipad))$ipad
    ]:

{map(length, image)[]};

viewimage := proc(image)
  for local line in image do
     printf(cat(line,"\n"));
  end do;
end proc:

viewimage(image);
# walk the image
nimage := image:

for gen to 50 do
    nwidth := length(nimage[1]);
    nlength := nops(nimage);
    nbuf := StringBuffer():
    for i from 2 to nlength-1 do
        for j from 2 to nwidth-1 do
            nbhd := cat( seq(nimage[i+k][j-1..j+1], k=-1..1));
            pxidx := bin2dec(nbhd);
            nbuf:-append(code[pxidx+1]);
        end do;
    end do;
    tmp :=  nbuf:-value();
    nimage := [ seq(tmp[(i-1)*(nwidth-2)+1..i*(nwidth-2)], i=1..nlength-2) ];
    nwidth := length(nimage[1]);
    nlength := nops(nimage);
    ipad := 2;
    p := ifelse(gen mod 2 = 1, code[1], code[bin2dec(cat(code[1]$9))+1]);
    nimage := [ cat(p$(nwidth+2*ipad))$ipad, seq(cat(p$ipad,nimage[i],p$ipad), i=1..nwidth), cat(p$(nwidth+2*ipad))$ipad ]:
end do:

viewimage(nimage);

answer2 := add(CountCharacterOccurrences(nimage[i], "#"), i=1..nops(nimage));


