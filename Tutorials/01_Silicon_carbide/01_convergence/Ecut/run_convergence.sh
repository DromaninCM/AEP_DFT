#!/bin/sh
Ecut="10 15 20 25 30 35 40 45 50 55 60"

for ec in $Ecut
do
er="8"
cat > SiC.scf.in << EOF
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
 celldm(1) = 8.2354297, 
 nat=2, ntyp=2,
 ecutwfc = ${ec},
 ecutrho = $[$er*$ec]
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

~/qe-6.5/bin/pw.x < SiC.scf.in > SiC_${ec}.scf.out
rm -rf tmp
done
