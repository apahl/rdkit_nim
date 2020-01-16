import ../src/rdkit / [mol, parsers]

when isMainModule:
  let
    smi = "c1ccccc1C(=O)NC"
    m = smilesToMol(smi)

  echo "Mol Ok:    ", m.ok

  if m.ok:
    let
      na = m.numAtoms
      mw = m.molWt
      rot = m.numRotatableBonds
      nh = m.numHeteroAtoms
    echo "Num Atoms:    ", na
    echo "Mol weight:   ", mw
    echo "Rot. Bonds:   ", rot
    echo "Num HetAtoms: ", nh
