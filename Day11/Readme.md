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

Reader, we animated the grid:

![Scratch animation](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day11/Day11ScratchAnimation.gif)

https://scratch.mit.edu/projects/615751043/

This combine visualization code from @whaleandbeaver 

![Scratch blocks](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day11/Day11-Scratch-Visualization.png)

and a fair amount of simulation code. I uses two different encodings for points an index 1-100 and [x,y] in 0..9 x 0..9
and conversions between the two led to so many painful debugging sessions. In retrospect, I should have returned neighbors
as a list, and then kept a queue, looping through every point that needed to be visited in the Flash update rather than trying
to use recursion since I had to keep two stacks to make that work in the end.

![Blocks](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day11/Day11-ScratchSimulation.png)

there were also definitely some hilarious bloopers when the visualization and the computation got into a bad state

![octopus amoeba](https://github.com/johnpmay/AdventOfCode2021/blob/main/Day11/Day11AkiraSituation-fast.gif)
