#!/bin/sh
kgrid="3 6 9 12 15 18"

for k in $kgrid
do
printf "${k}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' hBN_${k}.scf.out 
done > energy.dat
