# Nim RDKit Bindings

After many (, many) trials this is the first example of a working rudimentary binding of the C++ cheminformatics toolkit [RDKit](http://rdkit.org/) for the [Nim](https://nim-lang.org) programming language.


[Example](examples/ex01_mol_from_smiles.nim) for creating the mol object from the Smiles "c1ccccc1" and counting the heavy atoms:

    $ nim cpp -o:bin/ex01_mol_from_smiles examples/ex01_mol_from_smiles.nim 
    $ LD_LIBRARY_PATH=/home/pahl/anaconda3/envs/chem/lib ./bin/ex01_mol_from_smiles 2>/dev/null
    -> Num Atoms: 6

Since these are two of my most favorite tools, I am VERY excited.

Pre-requisites:
* Installations of RDKit (e.g. via `conda`) and Nim


The code still leaks memory, but I am now super-motivated to continue!
The code in this early iteration also uses hardcoded paths. If you want to run the examples under, please change the paths to match your installation.

Obviously, this project will change quickly. In the current state it is mainly for showing off my first success (did I mention that I am excited?).
