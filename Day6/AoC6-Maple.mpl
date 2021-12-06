input := FileTools:-Text:-ReadFile("AoC-2021-6-input.txt" ):
tally := table(sparse=0,Statistics:-Tally(
    StringTools:-Split(input,",")));
lanternfish := Array(0..8, [tally["0"],tally["1"],tally["2"],tally["3"],
    tally["4"],tally["5"],0,0,0]);
newday := Array(0..8);

for i to 256 do
    newday[0..7] := lanternfish[1..8];
    newday[8] := lanternfish[0];
    newday[6] := newday[6] + lanternfish[0];
    lanternfish[0..8] := newday[0..8]; # deep copy!
end do:

answer := add(newday);

