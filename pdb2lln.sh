#!/bin/bash

# Convert PDB file to the format lln.

if [ $# -ne 2 ]
then
	echo "Usage mode:"
	echo
	echo "	"$0" <pdb file> <lln output file>"
	exit 1
fi

awk '
	BEGIN{
		atom=0;
		id_atom=0;
		amino=0;
		p_atom=0;
		p_amino=0;
		cont=0;
	}
	/^ATOM/{
		if(p_amino != $6){
			p_amino=$6;
			cont=0;
		}
		if(p_atom == 0)
			p_atom = $2;

		if(cont < 3 && (id_atom+p_atom == $2)){

			vet[atom,0]=$7;
			vet[atom,1]=$8;
			vet[atom,2]=$9;
			for(j=0; j<atom; j++){
				dist=sqrt(($7-vet[j,0])^2 + ($8-vet[j,1])^2 + ($9-vet[j,2])^2);
				if(dist && dist<5){
#					printf "%d %d %.15f\n", j, atom, dist;
					mat[atom, j]=dist;
				}
			}
			atom++;
		}
		cont++;
		id_atom++;
	}
	END{

		print "# bond angles:";
		for(i=1; i<atom-1; i++){

			x = (mat[i+1, i]^2 + mat[i, i-1]^2 - mat[i+1, i-1]^2)/(2*mat[i, i-1]*mat[i+1, i]);
			printf "%.15f\n", atan2(sqrt (1-x * x), x);

		}

		print "# E distances:";
		for(i=0; i<atom-3; i++){
			printf "%.15f\n", mat[i+1,i];
			printf "%.15f\n", mat[i+2,i];
			printf "%.15f\n", mat[i+3,i];
		}
		printf "%.15f\n", mat[i+1,i];
		printf "%.15f\n", mat[i+2,i];
		i++;
		printf "%.15f\n", mat[i+1,i];

		print "# E edges:";
		for(i=1; i<atom-2; i++){
			printf "%d %d\n", i, i+1;
			printf "%d %d\n", i, i+2;
			printf "%d %d\n", i, i+3;
		}
		printf "%d %d\n", i, i+1;
		printf "%d %d\n", i, i+2;
		i++;
		printf "%d %d\n", i, i+1;

		print "# F distances:";
		cont=0;
		for(i=0; i<atom; i++)
			for(j=i+4; j<atom; j++)
				if(mat[j,i]){
					printf "%.15f\n", mat[j,i];
					vet[cont,0]=i+1;
					vet[cont++,1]=j+1;
				}

		print "# F edges:";
		for(i=0; i<cont; i++)
			printf "%d %d\n", vet[i,0], vet[i,1];

	}

' $1 > $2
