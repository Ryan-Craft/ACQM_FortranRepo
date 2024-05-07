

one_s(x) = 2*x*exp(-x)
two_s(x) = (x/sqrt(2))*(1-(x/2))*exp(-x/2)
three_s(x) = (2*x/sqrt(27))*(1-(2*x/3)+(2*x**2/27))*exp(-x/3)

set xrange [-0.1:20]
set yrange [-12:12]
set grid


plot one_s(x), two_s(x), three_s(x), 'wfout.txt' using 1:2 t "1s from program" ,'wfout.txt' using 1:3 t "2s from program", 'wfout.txt' using 1:4 t "3s from program"


