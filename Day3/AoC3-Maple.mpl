input := FileTools:-Text:-ReadFile("AoC-2021-3-input.txt" ):
bins := map(b->[seq(ifelse(b[i]="0",0,1), i=1..length(b))],
            StringTools:-Split(StringTools:-Trim(input)) ):

mostcommon := proc(L)
    map(b->ifelse(b>=nops(L)/2, 1, 0),
        [seq(add(L[j][i], j=1..nops(L)), i=1..nops(L[1]))] );
end proc:
leastcommon := proc(L) map(b->ifelse(b=0, 1, 0), mostcommon(L)); end proc:
bin2dec := proc(L) add(L[-i]*2^(i-1), i=1..nops(L)); end proc:

bin2dec(mostcommon(bins)) * bin2dec(leastcommon(bins)); # part 1 answer

o2gen_bins := bins:
for i to nops(bins[1]) while nops(o2gen_bins)<>1 do
   mc := mostcommon(o2gen_bins);
   o2gen_bins := select(r->r[i]=mc[i], o2gen_bins);
end do:

co2scrub_bins := bins:
for i to nops(bins[1]) while nops(co2scrub_bins)<>1 do
   mc := leastcommon(co2scrub_bins);
   co2scrub_bins := select(r->r[i]=mc[i], co2scrub_bins);
end do:

bin2dec( o2gen_bins[] ) * bin2dec( co2scrub_bins[] ); # part 2 answer

