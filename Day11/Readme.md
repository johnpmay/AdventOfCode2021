# Day 11

https://adventofcode.com/2021/day/11

## Maple

Another grid problem like Day 9. I chose to implement a helper function to
calculate neighbors without padding the grid like I did in day 9. That
might have been faster to code, however, this worked very smoothly.

Shockingly the real grid was the same size as the sample grid.

In the end the first part was similar to part 2 of day 9. A simple recursive
DFS with tracking to implement "flashing" chain reactions and finally a second
pass through the grid to reset flashers to 0 and count the total number of flashes.

The second part was just running the interation past 100 days to see when all jellyfish
hit 0 at once.  I had an off by one error on this one, that probably cost me a 100 places.

## Scratch

feels straight forward, I should probably animate the grid
