This folder contains the files for the convergence of the cutoff on the kinetic energy:

1. run_convergence.sh:\
   Bash script that performs scf computations using Quantum ESPRESSO utility pw.x for different values of "Ecut";
  
2. exctract_energy.sh :\
   Bash script that extracts the total energy from the output of an scf computation for various Ecut;
  
3. plot.gnu:\
   Gnuplot script for plotting the total energy per atom in eV as a function of Ecut;
   
4. energy_vs_Ecut.pdf:\
   Reference for the convergence of Ecut;
