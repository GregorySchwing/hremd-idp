#!/bin/bash
####################################################
####script below assumes gromacs is compiled####
####################################################

####If one is new to gromacs and encounters errors/problems, refer to an excellent tutorial by Justin Lemkul (http://www.mdtutorials.com/gmx/).

####NPT equilibration.
# For velocities
#-t nvt.cpt 
# From manual - https://manual.gromacs.org/documentation/current/onlinehelp/gmx-grompp.html
#Starting coordinates can be read from trajectory with -t. The last frame with coordinates and velocities will be read, unless #the -time option is used. Only if this information is absent will the coordinates in the -c file be used. Note that these #velocities will not be used when gen_vel = yes in your .mdp file. An energy file can be supplied with -e to read Nose-Hoover #and/or Parrinello-Rahman coupling variables.
gmx grompp -f mdp/npt.mdp -c nvt.gro -r nvt.gro -p topol.top -t nvt.cpt -o npt.tpr
# Checkpoint holds - thermostat/barostat variables, random number states and NMR time averaged data.
# Only used for velocities
# Cant use the checkpoint for some reason
gmx mdrun -cpt 5 -s npt.tpr -deffnm npt
