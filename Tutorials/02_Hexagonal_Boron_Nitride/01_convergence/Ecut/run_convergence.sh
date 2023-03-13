#!/bin/sh
Ecut="10 20 30 40 50 60 70"

for ec in $Ecut
do
er="8"
cat > hBN.scf.in << EOF
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
 celldm(1) = 4.716, celldm(3) = 2.582
 nat=4, ntyp=2,
 ecutwfc = ${ec},
 ecutrho = $[$er*$ec],
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
B -0.6666667 -0.3333333  0.5000000
N  0.6666667  0.3333333  0.5000000
K_POINTS automatic
 6 6 2 0 0 0
EOF

~/qe-6.5/bin/pw.x < hBN.scf.in > hBN_${ec}.scf.out
rm -rf tmp
done
