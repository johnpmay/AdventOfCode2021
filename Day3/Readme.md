# Advent of Code 2021 Day 3

The Maple solution is relatively straight forward

Storing the input in L, you can compute the most common bit string by adding down columns of L
and then if bigger the half the length of the list replace with 1, and 0 otherwise. Once you have
this key helper, the other parts are mostly easy loops
```
map(b->ifelse(b>=nops(L)/2, 1, 0),
    [seq(add(L[j][i], j=1..nops(L)), i=1..nops(L[1]))] );
```
Too bad I just realized this is more cleverly done as
```    
floor~([seq(add(L[j][i], j=1..nops(L)), i=1..nops(L[1]))] / nops(L) *2);
```


The Scratch solution was relatively difficult for me because I kept trying to use lists
and Scratch doesn't allow procedures, called "My Blocks", to take lists as input.
Next problem I try in Scratch, I will keep that lesson in mind.

![Scratch Code 313 Blocks](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day3/Advent%20of%20Code%202021%20Day%203%20Scratch.png)
