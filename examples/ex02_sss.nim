import rdkit / [molecule, descriptors, sss]

when isMainModule:
  let
    smi = "c1ccccc1C(=O)NC2CC2"    # cyclopropyl benzamide
    mol = molFromSmiles(smi)
    query = molFromSmiles("C1CC1") # cyclopropane

    # q = molFromSmiles("c1ccccc1")

  echo "Mol Ok:      ", mol.ok
  echo "Query Ok:    ", query.ok

  if mol.ok and query.ok:
    let
      na = mol.numAtoms
    echo "Num Atoms:    ", na

    echo mol.hasSubstructMatch(query)
    echo mol.numSubstructMatches(query)
    echo mol.substructMatches(query)

    let m2 = deleteSubstructs(mol, query)
    echo "NumAtoms after deletion: ", m2.numAtoms
    # echo m.toMolBlock
