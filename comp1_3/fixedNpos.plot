set grid
set minussign
set yrange [0.001:1000]
set xrange [0:7]
set logscale y

set xtics (0, 1, 2, 3, 4, 5, "inf" 6)

set title "Contiunuum Energy States in the Laguerre Basis"

set key left top
set xlabel "Laguerre Basis Size"
set ylabel "Energy (Hartrees)"

plot 'a1.txt' using 1:2 t "alpha=1"  , 'a2.txt' using 1:2 t "alpha=2" , 'a3.txt' using 1:2  t "alpha=2", 'a4.txt' using 1:2 t "alpha=4" , 'a5.txt' using 1:2  t "alpha=5", '< echo "6 1000"' w impulse t "continuum"
