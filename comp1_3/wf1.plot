


two_s(x) = (x/sqrt(2))*(1-(x/2))*exp(-x/2)


set xrange [-0.1:20]
set yrange [-12:12]
set grid


plot two_s(x), 'wfout.txt' using 1:3


