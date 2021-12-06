input := FileTools:-Text:-ReadFile("AoC-2021-6-input.txt" ):
tally := table(sparse=0,Statistics:-Tally(
    StringTools:-Split(input,",")));
lanternfish := Array(0..8, [tally["0"],tally["1"],tally["2"],tally["3"],
    tally["4"],tally["5"],0,0,0]);

to 256 do
    day0 := lanternfish[0];
    lanternfish[0..7] := lanternfish[1..8];
    lanternfish[8] := day0;
    lanternfish[6] := lanternfish[6] + day0;
end do:

answer2 := add(lanternfish);
