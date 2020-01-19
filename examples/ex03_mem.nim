import ../src/rdkit / [mol, parsers]

proc createLotsOfMolecules() =
  for i in 1 .. 10:
    let
      smi = "c1ccccc1C(=O)NC2CC2" # cyclopropyl benzamide
      m = smilesToMol(smi)

    if m.ok:
      let
        na = m.numAtoms

      m.destroy()

when isMainModule:
  echo getOccupiedMem()

  createLotsOfMolecules()

  echo getOccupiedMem()
