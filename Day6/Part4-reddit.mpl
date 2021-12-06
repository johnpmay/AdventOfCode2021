# https://www.reddit.com/r/adventofcode/comments/ra88up/2021_day_6_part_4_day_googolplex/
# Calculate the population at the googolplex generation mod nextprime(10^8)
input := "4,1,7,7,4,7,6,2,5,4,3,1,4,7,2,4,5,2,2,1,3,7,4,5,1,3,3,5,5,7,6,3,3,3,7,7,5,4,6,3,1,7,6,1,3,5,1,2,6,6,5,5,4,3,2,6,5,3,7,5,4,2,1,3,6,2,7,2,2,6,5,6,7,6,3,3,1,1,1,3,7,3,3,5,4,7,2,1,4,4,1,2,5,5,4,3,4,4,7,4,2,1,2,2,4":
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
# x^9 - x^2 - 1

q := 100000007:

# look for a power of x that is 1 modulo the minpoly in F_q[x]
for i from 1 to 100 do
   qq := q^i-1;
   # x^qq ( mod minpoly ) in F_q[x]
   if Powmod(x, qq, minpoly, x) mod q = 1 then
        break;
   end if;
end do:
i, qq;
# i=8, qq=10000005600001372000192080016807000941192032941720658834405764800

# qq is the period of powers of U mod q

# calculate googolplex mod qq
n := Power(10, 10^100) mod qq;
# 7308711993169798294967234678458568672383628022002873653735230400
# so U^googolplex = U^n mod q

# I like computing powers of U using the minpoly
g := Powmod(x, n, minpoly, x) mod q;
# 46714893*x^8+75968618*x^7+86556894*x^6+35145482*x^5+7013179*x^4
#  +30172454*x^3+81311138*x^2+30235098*x+46689635

# g(U) = U^googolplex mod q

add(eval(g, x=U) . lanternfish) mod q;
# 52292574

