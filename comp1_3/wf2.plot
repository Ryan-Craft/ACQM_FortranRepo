

two_p(x) = (x**2/sqrt(24))*exp(-x/2)
three_p(x) = (8*x**2/(27*sqrt(6)))*(1-(x/6))*exp(-x/3)

set xrange [-0.1:20]
set yrange [-12:12]
set grid


plot two_p(x), three_p(x), 'wfout.txt' using 1:2 t "2p from program", 'wfout.txt' using 1:3 t "3p from program"


