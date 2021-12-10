# Day 10

https://adventofcode.com/2021/day/10

## Maple

I thought StringTools:-MatchFence or StringTools:-IsBalanced but the former does not support
the angle brackets used in the problem and the latter does not give enough information to 
solve the problem (none of the input lines have Balanced parens! you have to sort them into
which time of misbalanced exist).

After wasting time on that, I went with the Computer Science 101 stack-based solution to paren
matching using the delightfully fast and versatile `DEQueue` object in Maple
(it's been around since Maple 15, but only documented since Maple 2021).

I wasted time on overly complicated stuff to check if brackets were "open" or "close" and then
to look up the matching bracket which was buggy.  Otherwise, the code was simple: push open braces
and pop close braces error when they don't match and do bookkeeping required for the puzzle answers.

It's also slightly annoying that `Statistics:-Median` reports float answers for lists of integers.

## Scratch

Scratch lists are *perfect* for using as Stacks, so it was pretty straight forward to do the matching.
I put the open and close braces (and points from the problem!) in the same order in different lists so
I could easily look up matching braces and scores (should have done that in Maple too!).

I didn't implement a Median algorithm for Day 6 because it probably wouldn't have saved much time, but
it was totally necessary to solve part 2 on this problem. So I wrote one that only works with odd-length
lists.

https://scratch.mit.edu/projects/614648591/

![scratch blocks](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day10/AoC2021-ScratchDay10.png)
