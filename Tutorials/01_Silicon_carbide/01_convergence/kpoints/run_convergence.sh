#!/bin/sh
kgrid="2 3 4 5 6 7 8 9 10 11 12 13 14"

for k in $kgrid
do
cat > SiC.scf.in << EOF
&CONTROL
 calculation = 'scf',
 restart_mode='from_scratch',
 prefix = 'SiC',
 pseudo_dir = '../../Pseudo',
 outdir = './tmp',
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
 ibrav = 2, 
 celldm(1) = 8.2354297, 
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
 ${k} ${k} ${k} 0 0 0
EOF

~/qe-6.5/bin/pw.x < SiC.scf.in > SiC_${k}.scf.out
rm -rf tmp
done
