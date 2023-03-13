#!/bin/sh
vacuum="10 15 20 25 30 35 40 45"
a=4.716
c=12.176712

for v in $vacuum
do
RESULT=$(echo "($c+$v)/$a" | bc -l)
printf "${RESULT}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' hBN_surface_${RESULT}.scf.out 
done > energy.dat
