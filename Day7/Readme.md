# Day 7

This was a very fast optimization problem, brute force got both answers pretty quickly (although you might have needed to know 
`sum(i,i=1..n) = (n^2+n)/2` to be really competitive: 2s vs. 75s in Maple). I managed 1860th / 1712th places.

    pos := parse~(StringTools:-Split(input,",")):
    answer1 := min(seq(add(abs~(pos-~i)),i=min(pos)..max(pos)));
    answer2 := min(seq( 
        add(((pos[i]-j)^2+abs(pos[i]-j))/2, i=1..nops(pos)),
            j=min(pos)..max(pos)));
            
A nice observation on Reddit is that the *median* of the list pos is actually garunteed to be the minimum in part 1.

Several people stated that the *mean* of pos was then the minimum point in answer two.
But since the sum is of `(n^2+abs(n))/2` and not `n^2`, that is not actually correct.  However, if differentiate to find
the minimum of `sum(((x_i-m)^2+abs(x_i-m))/2,i=1..n)` you get

    m = sum(x_i,i=1..n)/n - sum(signum(x_i-m),i=1..n)/n/2 = mean(x_i) - mean(signum(x_i-m))/2  
    ==> mean(x_i) - 1/2 <= m <= mean(x_i) + 1/2
    
so by lucky rounding, sometimes the mean is actually the minimum.
