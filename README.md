# Nim RDKit Bindings

After many (, many) trials this is the first example of a working rudimentary binding of the C++ cheminformatics toolkit [RDKit](http://rdkit.org/) for the [Nim](https://nim-lang.org) programming language.


[Example](examples/ex01_mol_from_smiles.nim) for creating the mol object from the Smiles "c1ccccc1" and counting the heavy atoms:

    $ nim build examples/ex01_mol_from_smiles.nim 
    $ LD_LIBRARY_PATH=$RDKIT_NIM_CONDA/lib ./bin/ex01_mol_from_smiles
    
    Output:
    Mol Ok:    true
    Num Atoms: 6

Since these are two of my most favorite tools, I am VERY excited.

Pre-requisites:
* Installations of RDKit (e.g. via `conda`) and Nim


The code still leaks memory, but I am now super-motivated to continue!
The path to your conda installation of the RDKit has to be set by an environment variable, e.g. in `~/.profile`:

    export RDKIT_NIM_CONDA=/home/pahl/anaconda3/envs/chem

Obviously, this project will change quickly. In the current state it is mainly for showing off my first success (did I mention that I am excited?).
