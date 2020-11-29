#!/bin/sh
alat="7.8154297 7.8454297 7.8754297 7.9054297 7.9354297 7.9654297 7.9954297 8.0254297 8.0554297 8.0854297 8.1154297 8.1454297 8.1754297 8.2054297 8.2354297 8.2654297 8.2954297 8.3254297 8.3554297 8.3854297 8.4154297 8.4454297 8.4754297 8.5054297 8.5354297 8.5654297 8.5954297 8.6254297"

for a in $alat
do
cat > SiC.relax.in << EOF
&CONTROL
 calculation = 'scf',
 restart_mode='from_scratch',
 prefix = 'SiC',
 pseudo_dir = '../../pseudopotentials',
 outdir = './tmp',
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
 ibrav = 2, 
 celldm(1) = ${a}, 
 nat=2, ntyp=2,
 ecutwfc = 40.00,
 ecutrho = 320.00
/
&ELECTRONS
 conv_thr =   1.0d-9
/
ATOMIC_SPECIES
 C  12.011   C.pbe-n-rrkjus_psl.1.0.0.UPF
Si  28.090  Si.pbe-nl-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS crystal
 C 0.00000 0.00000 0.00000
Si 0.25000 0.25000 0.25000
K_POINTS automatic
 6 6 6 0 0 0
EOF

~/qe-6.5/bin/pw.x < SiC.relax.in > SiC_${a}.relax.out
rm -rf tmp
done
