#!/bin/bash
####################################################
####script below assumes gromacs is compiled####
####################################################

####If one is new to gromacs and encounters errors/problems, refer to an excellent tutorial by Justin Lemkul (http://www.mdtutorials.com/gmx/).


####Generate a gromacs tpr for production run.
gmx grompp -f mdp/md.mdp -c npt.gro -t npt.cpt -p topol.top -o md.tpr
# Checkpoint holds - thermostat/barostat variables, random number states and NMR time averaged data.
# Only used for velocities
gmx mdrun -cpt 5 -s npt.tpr -deffnm prod
