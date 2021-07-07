#!/bin/bash
####################################################
####script below assumes gromacs is compiled####
####################################################

####If one is new to gromacs and encounters errors/problems, refer to an excellent tutorial by Justin Lemkul (http://www.mdtutorials.com/gmx/).

####NPT equilibration.
gmx grompp -f mdp/npt.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt.tpr
# gmx mdrun -append -cpt 5 -s npt.tpr -deffnm npt
# Checkpoint holds - thermostat/barostat variables, random number states and NMR time averaged data.
# Only used for restarting if hardware/software prematurely terminates
# Cant use the checkpoint from nvt to continue npt equilibration
gmx mdrun -cpi nvt.cpt -cpt 5 -s npt.tpr -deffnm npt
