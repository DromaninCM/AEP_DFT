#!/bin/sh
kgrid="8 10 12 14 16 18 20 22 24"

# Perform the SCF computation
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
 celldm(1) = 8.2730700, 
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
~/qe-6.5/bin/pw.x < SiC.scf.in > SiC.scf.out

# Perform convergence of DOS
for k in $kgrid
do
# Perform the nscf computation
cat > SiC.nscf.in << EOF
&CONTROL
 calculation = 'nscf',
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
 celldm(1) = 8.2730700, 
 nat=2, ntyp=2,
 ecutwfc = 40.00,
 ecutrho = 320.00
 occupations = 'tetrahedra',
 nbnd = 8
/
&ELECTRONS
 conv_thr =   1.0d-9
 diago_full_acc = .true.
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
~/qe-6.5/bin/pw.x < SiC.nscf.in > SiC_${k}.nscf.out

# Perform the DOS computation
cat > dos.in << EOF
&DOS
outdir = './tmp'
prefix = 'SiC'
fildos = 'SiC_${k}.dos'
/
EOF
~/qe-6.5/bin/dos.x < dos.in > dos_${k}.out
done
rm -rf tmp
