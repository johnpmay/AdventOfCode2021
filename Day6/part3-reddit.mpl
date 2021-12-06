# https://www.reddit.com/r/adventofcode/comments/ra3f5i/2021_day_6_part_3_day_googol/
# Get the 10^100th generation of Lantern fish 

input := "3,1,1,0,3,7,5,5,2,4,2,1,0,2,6,4,3,0,2,1,5,1,4,2,3,0,6,3,0,5,0,5,6,0,0,6,7,0,1,6,3,2,1,1,2,2,0,1,1,1,6,0,2,1,0,5,1,4,7,6,3,0,7,2,0,0,2,0,2,7,3,7,2,4,6,1,6,6,1,1,6,3,3,1,0,4,5,0,5,1,2,0,2,0,7,4,6,1,6,1,5,0,0,2,3":
tally := table(sparse=0,Statistics:-Tally(StringTools:-Split(input,","))):
lanternfish := Vector([seq(tally[cat("",i)],i=0..8)]):

U := Matrix([
 [0, 1, 0, 0, 0, 0, 0, 0, 0],
 [0, 0, 1, 0, 0, 0, 0, 0, 0],
 [0, 0, 0, 1, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 1, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 1, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 1, 0, 0],
 [1, 0, 0, 0, 0, 0, 0, 1, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 1],
 [1, 0, 0, 0, 0, 0, 0, 0, 0]]):

minpoly := LinearAlgebra:-MinimalPolynomial(U,x);

q:=10^20:
n := 10^100: # googol

# reduce x^n modulo the minpoly to get g so g(U) = U^n
g := Powmod(x, n, minpoly, x) mod q:

add(eval(g, x=U) . lanternfish) mod q;
# 80595178351181834124

