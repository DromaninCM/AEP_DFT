#!/bin/sh
kgrid="2 3 4 5 6 7 8 9 10 11 12 13 14"

for k in $kgrid
do
printf "${k}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' SiC_${k}.scf.out 
done > energy.dat
