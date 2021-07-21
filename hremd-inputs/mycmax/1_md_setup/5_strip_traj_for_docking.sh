#!/bin/bash
####################################################
####script below assumes gromacs is compiled########
####################################################


####If one is new to gromacs and encounters errors/problems, refer to an excellent tutorial by Justin Lemkul (http://www.mdtutorials.com/gmx/).

####2 is Protein minus hydrogen, we center protein and output
gmx trjconv -s md.tpr -f prod_center.trr -o prod_center_no_h.trr -center -pbc mol -ur compact <<EOF
2
2
EOF

gmx trjconv -s md.tpr -f prod_center.trr -o frameForAlignment.pdb -center -pbc mol -ur compact -dump 0 <<EOF
2
2
EOF

gmx trjconv -s frameForAlignment.pdb -f prod_center_no_h.trr -o prod_center_no_h_aligned.trr -fit progressive -center <<EOF
0
0
0
EOF
