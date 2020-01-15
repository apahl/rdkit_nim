import ../src/rdkit / [mol, smiles_parser]

when isMainModule:
  var
    smi = "c1ccccc1"
    m = smilesToMol(smi)

  echo "Mol Ok:    ", m.ok

  if m.ok:
    var na = m.numAtoms()
    echo "Num Atoms: ", na
