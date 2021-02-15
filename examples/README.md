# Examples

Compile the examples from the root folder of the project with:

    $ nim build examples/<example_file.nim>

e.g.

    nim build examples/ex01_mol_from_smiles.nim

Then run it from the same folder as:

    LD_LIBRARY_PATH=$RDKIT_CONDA/lib ./bin/ex01_mol_from_smiles

    Output:
        Mol Ok:    true
        Num Atoms:    10
        Mol weight:   135.166
        Rot. Bonds:   1
        Num HetAtoms: 2

Depending on your RDKit installation, you need to give the `LD_LIBRARY_PATH` to the RDKit installation or not, when starting the project (see above).