#!/bin/bash
####################################################
####script below assumes gromacs is compiled####
####################################################

####If one is new to gromacs and encounters errors/problems, refer to an excellent tutorial by Justin Lemkul (http://www.mdtutorials.com/gmx/).

####NVT equilibration.
gmx grompp -f mdp/nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
# Checkpoint holds - thermostat/barostat variables, random number states and NMR time averaged data.
# Only used for restarting if hardware/software prematurely terminates
# Cant use the checkpoint from nvt to continue npt equilibration
gmx mdrun -cpt 5 -s nvt.tpr -deffnm nvt
