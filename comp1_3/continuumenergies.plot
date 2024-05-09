set grid
set minussign
set yrange [0.001:1000]
set xrange [0:80]
set logscale y

set xtics (0, 10, 20, 30, 40, 50, "inf" 60)

set title "Contiunuum Energy States in the Laguerre Basis for l=0, alpha=1"

set key top right

set xlabel "Laguerre Basis Size"
set ylabel "Energy (Hartrees)"

set key font ",12"
set title font ",14"
set tics font ",12"
set xlabel font ",12"
set ylabel font ",12"


plot 'wout.txt' using 1:2 title "Bound Energies from Program" pointsize 2, '< echo "60 1000"' w impulse t "Continuum Analytical Energies" lw 2
