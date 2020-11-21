set term aqua enhanced dashed

set size 0.9, 0.9
set origin 0.05, 0.05

set xlabel "E_{cut} (Ry)" font "Times New Roman, 33" offset 0,-1
set ylabel "Energy/atom (eV)" font "Times New Roman, 33" offset -3,0

set tics font "Times New Roman, 25" 
unset key

set arrow from 40,graph(0,0) to 40,graph(1,1) nohead dt 2 lc rgb "red" lw 3

plot "energy.dat" u ($1):($2*13.6/2) w lp lc rgb "black" lw 2
