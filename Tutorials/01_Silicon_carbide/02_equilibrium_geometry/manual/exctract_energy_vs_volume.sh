#!/bin/sh
alat="7.9054297 7.9354297 7.9654297 7.9954297 8.0254297 8.0554297 8.0854297 8.1154297 8.1454297 8.1754297 8.2054297 8.2354297 8.2654297 8.2954297 8.3254297 8.3554297 8.3854297 8.4154297 8.4454297 8.4754297 8.5054297 8.5354297"

for a in $alat
do
awk 'BEGIN{FS=" *= *"} /unit-cell volume/{split($2,a," +");printf a[1]}' SiC_${a}.relax.out
awk 'BEGIN{FS=" *= *"} /!    total energy/{split($2,a," +");print "  " a[1]}' SiC_${a}.relax.out 
done > energy_vs_volume.dat
