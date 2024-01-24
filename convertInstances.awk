
/#/{
	if (mode == 1) {
	
		nAtoms = i + 2;
	}
	else if (mode == 2) {

		nEdist = i;
	}
	else if (mode == 3) {

		nEedge = i;
	}
	else if (mode == 4) {

		nFdist = i;
	}
	else if (mode == 5) {

		nFedge = i;
	}
	
	mode++; 
	i = 0;
} 

!/#/{
	
	if (mode == 1) {
	
		angle[i++] = $1;
	}
	else if (mode == 2) {

		Edist[i++] = $1;
	}
	else if (mode == 4) {

		Fdist[i++] = $1;
	}
	else if (mode == 5) {

		Fedges[i++] = $0;
	}
}

END{

	nFedge = i;
	print nAtoms;
	for (i = 0 ; i < nAtoms - 2; i++) {

		print angle[i];
	}
	for (i = 0 ; i < 3*(nAtoms - 2); i++) {

		print Edist[i];
	}
	for (i = 0 ; i < nFdist; i++) {

		printf "%s %s\n", Fedges[i], Fdist[i];
	}

#	printf "nAtoms = %s\n", nAtoms;
#	printf "nEdist = %s\n", nEdist;
#	printf "nEedge = %s\n", nEedge;
#	printf "nFdist = %s\n", nFdist;
#	printf "nFedge = %s\n", nFedge;
}

