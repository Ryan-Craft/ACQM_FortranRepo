
set xlabel "x"
set ylabel "y"
set zlabel "z"
set xrange[0:80]
set zrange[0:80]
set yrange[0:150]

set xyplane 0

file = "3d-project.dat"
n = system(sprintf('cat %s | wc -l', file))

set grid
set grid ztics

set term gif animate delay 3
set output 'output.gif'
do for [j=1:n]{
	set title 'time'.j
	splot file u 1:2:3 every ::1::j w l lw 2, \
	      file u 1:2:3 every ::j::j w p pt 7 ps 2      

}

