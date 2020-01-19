# Nim RDKit Bindings

After many (, many) trials this is the first example of a working rudimentary binding of the C++ cheminformatics toolkit [RDKit](http://rdkit.org/) for the [Nim](https://nim-lang.org) programming language.


[Example](examples/ex01_mol_from_smiles.nim) for creating the mol object from the Smiles "c1ccccc1C(=O)NC" (methyl benzamide) and calculating some properties:

    $ nim build examples/ex01_mol_from_smiles.nim 
    $ LD_LIBRARY_PATH=$RDKIT_NIM_CONDA/lib ./bin/ex01_mol_from_smiles
    
    Output:
        Mol Ok:    true
        Num Atoms:    10
        Mol weight:   135.166
        Rot. Bonds:   1
        Num HetAtoms: 2

Since these are two of my most favorite tools, I am VERY excited.

Pre-requisites:
* Installations of RDKit (e.g. via `conda`) and Nim


The path to your conda installation of the RDKit has to be set by an environment variable, e.g. in `~/.profile`:

    export RDKIT_NIM_CONDA=/home/pahl/anaconda3/envs/chem

~~Valgrind is not reporting any errors, so the package should not leak memory, but I will keep an eye on this.~~
[UPDATE 19-Jan-2020]: Apparently, the code from [example03](examples/ex03_mem.nim) **IS** leaking memory, regardless whether the ROMol object destructor is called explicitly, or not. <u>This is a road block for me.</u>

Obviously, this project will change quickly. In the current state it is mainly for showing off my first success (did I mention that I am excited?).

The following functionality from RDKit has been wrapped so far:

* Parsing of molecules from Smiles and Smarts: `smilesToMol, smartsToMol`
* Calculation of molecular properties: `numAtoms, molWt, numRings, cLogP, numHBA, numHBD`
* Substructure search: `hasSubstructMatch, numSunstructMatches, substructMatches`

For further usage, until a real documentation becomes available, please have a look at the tests.


## Installation

Clone the repo, `cd` into it and install with `nimble install`.  
From the repo dir you can also run the tests with `nimble test`.

To use the package in your own projects, the imports then have to be of the form:

    import rdkit / [mol, parsers]

Please remember to list the shared object files that need to be linked from RDKit for compilation in the NimScript `.nims` files for each source file. Again, have a look at the examples and the tests for this.
When running the compiled programs, remember to prepend the call to the binary with the `LD_LIBRARY_PATH`, e.g.:

    $ LD_LIBRARY_PATH=$RDKIT_NIM_CONDA/lib my_program

Permanently modifying `LD_LIBRARY_PATH` (e.g. in `~/.profile`) or adding the path in `/etc/ld.so.conf.d/` has messed up my system and lead to errors in other programs, this is therefore not recommended. If someone has an idea how to do this more elegantly, please let me know.
