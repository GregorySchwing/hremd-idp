#!/bin/bash
####################################################
####script below assumes gromacs is compiled####
####################################################

####If one is new to gromacs and encounters errors/problems, refer to an excellent tutorial by Justin Lemkul (http://www.mdtutorials.com/gmx/).

####NPT equilibration.
# For velocities
#-t nvt.cpt 
gmx grompp -f mdp/npt.mdp -c nvt.gro -r nvt.gro -p topol.top -t nvt.cpt -o npt.tpr
# Checkpoint holds - thermostat/barostat variables, random number states and NMR time averaged data.
# Only used for velocities
# Cant use the checkpoint for some reason
gmx mdrun -cpt 5 -s npt.tpr -deffnm npt
