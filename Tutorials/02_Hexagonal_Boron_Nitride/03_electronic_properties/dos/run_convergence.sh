#!/bin/sh
kgrid="6 12 18 24 30 36"

# Perform the SCF computation
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
 ibrav = 0, 
 celldm(1) = 4.716
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
CELL_PARAMETERS (alat=  4.71600000)
   1.005988001  -0.000000000   0.000000000
  -0.502994001   0.871211165   0.000000000
   0.000000000   0.000000000   6.822882000
ATOMIC_POSITIONS crystal
B  0.6666667  0.3333333  0.0000000
N -0.6666667 -0.3333333  0.0000000
K_POINTS automatic
 6 6 1 0 0 0
EOF
~/qe-6.5/bin/pw.x < hBN_surface.scf.in > hBN_surface.scf.out

# Perform convergence of DOS
for k in $kgrid
do
# Perform the nscf computation
cat > hBN_surface.nscf.in << EOF
&CONTROL
 calculation = 'nscf',
 restart_mode='from_scratch',
 prefix = 'hBN',
 pseudo_dir = '../../pseudopotentials',
 outdir = './tmp',
 tprnfor = .true.,
 tstress = .true.,
 verbosity = 'high',
/
&SYSTEM
 ibrav = 0, 
 celldm(1) = 4.716
 nat=2, ntyp=2,
 ecutwfc = 40.0,
 ecutrho = 320.0,
 assume_isolated = '2D'
 nbnd = 12
 occupations = 'tetrahedra'
/
&ELECTRONS
 conv_thr = 1.0d-9
 diago_full_acc = .true.
/
ATOMIC_SPECIES
B 10.811    B.pbe-n-rrkjus_psl.1.0.0.UPF
N 14.00674  N.pbe-n-rrkjus_psl.1.0.0.UPF
CELL_PARAMETERS (alat=  4.71600000)
   1.005988001  -0.000000000   0.000000000
  -0.502994001   0.871211165   0.000000000
   0.000000000   0.000000000   6.822882000
ATOMIC_POSITIONS crystal
B  0.6666667  0.3333333  0.0000000
N -0.6666667 -0.3333333  0.0000000
K_POINTS automatic
 ${k} ${k} 1 0 0 0
EOF
~/qe-6.5/bin/pw.x < hBN_surface.nscf.in > hBN_surface_${k}.nscf.out

# Perform the DOS computation
cat > dos.in << EOF
&DOS
outdir = './tmp'
prefix = 'hBN'
fildos = 'hBN_${k}.dos'
/
EOF
~/qe-6.5/bin/dos.x < dos.in > dos_${k}.out
done
rm -rf tmp
