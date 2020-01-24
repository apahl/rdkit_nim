import rdkit / [mol, descriptors, sss]

when isMainModule:
  let
    smi = "c1ccccc1C(=O)NC2CC2" # cyclopropyl benzamide
    m = molFromSmiles(smi)
    q = molFromSmiles("C1CC1")  # cyclopropane

    # q = molFromSmiles("c1ccccc1")

  echo "Mol Ok:      ", m.ok
  echo "Query Ok:    ", q.ok

  if m.ok and q.ok:
    let
      na = m.numAtoms
    echo "Num Atoms:    ", na

    echo m.hasSubstructMatch(q)
    echo m.numSubstructMatches(q)
    echo m.substructMatches(q)
