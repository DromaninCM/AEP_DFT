#!/bin/sh
Ecut="10 15 20 25 30 35 40 45 50 55 60"

for ec in $Ecut
do
printf "${ec}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' SiC_${ec}.scf.out 
done > energy.dat
