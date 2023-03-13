#!/bin/sh
Ecut="10 20 30 40 50 60 70"

for ec in $Ecut
do
printf "${ec}"
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' hBN_${ec}.scf.out 
done > energy.dat
