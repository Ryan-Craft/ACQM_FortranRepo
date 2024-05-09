set grid
set minussign
set yrange [0.6:0.001]
set xrange [0:70]
set logscale y
set ytics ( "-0.1" 0.1,"-0.01" 0.01,"-0.001" 0.001)
set xtics (0, 5, 10, 20, 30, 40, 50, "inf" 60 )

set title "Bound Energy States of Hydrogen in\n the Laguerre Basis, l=0, alpha=1 "


set key left top
set xlabel "Laguerre Basis Size"
set ylabel "Energy (Hartrees)"
set tics font ",12"

set parametric

plot 'wout.txt' using 1:(-$2) title "Bound Energies from Program" pointtype 2 pointsize 2, 'analytical.txt' using 1:(-$2) title "Analytical Energies" pointtype 1 pointsize 2
