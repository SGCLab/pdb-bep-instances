# PDB to BeP instance Converter

Scripts in shell script and awk to convert PDB instances to a Branch-and-Prune instance (extension .ins).

# Example of use:

1) Download PDB instance. For example:

    `wget https://files.wwpdb.org/pub/pdb/data/structures/divided/pdb/ad/pdb2adn.ent.gz`

2) Unzip the file with gzip:

    `gzip -d -q pdb2adn.ent.gz`

3) Convert PDB to LLN:

    `./pdb2lln.sh pdb2adn.ent 2ADN.lln`

4) Convert LLN to ins (the script will generate a file with .ins extension):

    `./lln2ins.sh 2ADN.lln`

For the example, I can run my program using `2ADN.ins` as input.
