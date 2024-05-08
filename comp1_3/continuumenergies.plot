set grid
set minussign
set yrange [0.001:1000]
set xrange [0:70]
set logscale y

set xtics (0, 10, 20, 30, 40, 50, "inf" 60)

set title "Contiunuum Energy States in the Laguerre Basis"

set key left top
set xlabel "Laguerre Basis Size"
set ylabel "Energy (Hartrees)"

plot 'wout.txt' using 1:2 title "Bound Energies from Program", '< echo "60 1000"' w impulse
