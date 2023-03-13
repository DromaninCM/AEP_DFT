#!/bin/sh
vacuum="10 15 20 25 30 35 40 45"
a=4.716
c=12.176712

for v in $vacuum
do
RESULT=$(echo "($c+$v)/$a" | bc -l)
cat > hBN_surface.scf.in << EOF
&CONTROL
 calculation = 'scf',
 restart_mode='from_scratch',
 prefix = 'hBN',
 pseudo_dir = '../../pseudopotentials',
 outdir = './tmp',
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
 ibrav = 4, 
 celldm(1) = 4.716, celldm(3) = ${RESULT},
 nat=2, ntyp=2,
 ecutwfc = 40.0,
 ecutrho = 320.0,
 assume_isolated = '2D'
/
&ELECTRONS
 conv_thr = 1.0d-9
/
ATOMIC_SPECIES
B 10.811    B.pbe-n-rrkjus_psl.1.0.0.UPF
N 14.00674  N.pbe-n-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS crystal
B  0.6666667  0.3333333  0.0000000
N -0.6666667 -0.3333333  0.0000000
K_POINTS automatic
 6 6 1 0 0 0
EOF

~/qe-6.5/bin/pw.x < hBN_surface.scf.in > hBN_surface_${RESULT}.scf.out
rm -rf tmp
done
