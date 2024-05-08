set grid
set minussign
set yrange [0.6:0.005]
set xrange [0:7]
set logscale y
set ytics ( "-0.1" 0.1, "-0.2" 0.2,"-0.3" 0.3,"-0.4" 0.4,"-0.5" 0.5, "-0.6" 0.6,"-0.01" 0.01, "-0.02" 0.02 ,"-0.03" 0.03,"-0.04" 0.04,"-0.05" 0.05,"-0.06" 0.06,"-0.07" 0.07,"-0.08" 0.08,"-0.09" 0.09,  "-0.001" 0.001,"-0.002" 0.002,"-0.003" 0.003,"-0.004" 0.004,"-0.005" 0.005 ,"-0.006"  0.006,"-0.007" 0.007,"-0.008" 0.008,"-0.009" 0.009)
set xtics (1, 2, 3, 4, 5, "inf" 6)
set grid mytics

set title "Bound Energy States of Hydrogen in\n the Laguerre Basis"


set key left top
set xlabel "Alpha"
set ylabel "Energy (Hartrees)"

plot 'a1.txt' using 1:(-$2) t "alpha=1" ,'a2.txt' using 1:(-$2) t "alpha=2" ,'a3.txt' using 1:(-$2) t "alpha=3" ,'a4.txt' using 1:(-$2) t "alpha=4",'a5.txt' using 1:(-$2) t "alpha=5", 'analytical2.txt' using 1:(-$2) t "Analytical Energies"
