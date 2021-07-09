import re
import sys
# Writing to file
#file1 = open('processed.top', 'w')

print ('Number of arguments:', len(sys.argv), 'arguments.')
print ('Argument List:', str(sys.argv))
print("Arguments passed:", end = " ")
for i in range(1, len(sys.argv)):
    print(sys.argv[i], end = " ")

if (len(sys.argv) < 2):
	print ('\nUsage: appendUnderscoreToSolute.py your_topology_file.top soluteMolecule1 soluteMolecule2 ...')
	sys.exit(1)

dotTop = '.top'
if(dotTop not in sys.argv[1]):
	print ('\nUsage: appendUnderscoreToSolute.py your_topology_file.top soluteMolecule1 soluteMolecule2 ...')
	sys.exit(1)

inputfilename = sys.argv[1]
outputfilename = sys.argv[1][:-4] + '_.top'
print("outputfilename: ", outputfilename)
with open(inputfilename) as inf:
    content = inf.readlines()

inf.close()

blank=''
atomTypeHeader = '[ moleculetype ]'
#\n; Name            nrexcl\n'

print("File length: ",len(content))
enteredAtomSection = False

moleculeToScale = ''
blank = '\n'
atoms = "[ atoms ]"
bonds = "[ bonds ]"
listOfFirstAndLastIndices = []
firstLineOfAtoms = 0
lastLineOfAtoms = 0
enteredAtomSection = False
counterOfMoleculesAppended = 0
listOfMoleculesAppended = []
# Get (start, end) tuples of atom section of solute molecules
for i in range(2, len(sys.argv)):
	print("Scaling ", sys.argv[i])
	moleculeToScale = sys.argv[i]

	for j in range(0, len(content)):
		if moleculeToScale in content[j]: 
			if content[j+1] is blank and atoms in content[j+2]:
				firstLineOfAtoms = j + 5
				enteredAtomSection = True
		if enteredAtomSection and bonds in content[j]:
			lastLineOfAtoms = j - 2
			temp = (firstLineOfAtoms, lastLineOfAtoms)
			listOfFirstAndLastIndices.append(temp)
			enteredAtomSection = False
			counterOfMoleculesAppended = counterOfMoleculesAppended + 1
			listOfMoleculesAppended.append(moleculeToScale)

# Replace character immediately following atom name with a '_'
if (counterOfMoleculesAppended != len(sys.argv) - 2):
	print("Couldn't find all molecules!")
	print("I only found : ", listOfMoleculesAppended)
	print("Terminating without appending the underscore.")
	print("Correct your arguments or topology file!")
	sys.exit(1)

index = 17
print("Tuples of (start, stop) of atom sections: ",listOfFirstAndLastIndices)
for a_tuple in listOfFirstAndLastIndices:
	for i in range(a_tuple[0], a_tuple[1]+1):
		if(content[i][0] != ';'):
			content[i] = content[i][:index] + '_' + content[i][index + 1:]

of = open(outputfilename, "w")
of.writelines(content)
of.close()
print("\nAppended an underscore to all atoms in the molecules you provided!")
print('\x1b[6;30;42m' + 'Success!' + '\x1b[0m')

