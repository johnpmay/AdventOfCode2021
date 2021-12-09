# Day 6

https://adventofcode.com/2021/day/6

The worked example in the problem tricked a lot of people into putting each individual lantern fish
into a list and then part 2 was do the same thing bug longer (256 generations) which would create a
list of length 2^40 ~ 10^12 which is intractable in almost all environments.

The solution I used (along with most people) was to keep an array of counts of fish with each timer value
0-8. I even took advantage of custom indexing in Arrays to have it start at 0:

    lanternfish := Array(0..8, [tally["0"],tally["1"],tally["2"],tally["3"],
        tally["4"],tally["5"],0,0,0]);
        
I did the linear update manually

    day0 := lanternfish[0];
    lanternfish[0..7] := lanternfish[1..8];
    lanternfish[8] := day0;
    lanternfish[6] := lanternfish[6] + day0;

But it can also be done as a matrix multiplication which is necassary to solve the community challenges
to compute information about the [googol-th (10^100)](https://www.reddit.com/r/adventofcode/comments/ra3f5i/2021_day_6_part_3_day_googol/)
and [googolplex-th (10^(10^100))](https://www.reddit.com/r/adventofcode/comments/ra88up/2021_day_6_part_4_day_googolplex/) generations.

My Scratch Solution https://scratch.mit.edu/projects/613744867/ is just the manual linear update above in 138 blocks
and gets both answers in less than a second (I figured out how to time my code in Scratch!).
![138 Scratch blocks](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day6/AOC2021-Scratch-Day6.png)
