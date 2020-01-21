import rdkit / [mol, parsers, sss]

proc createLotsOfMolecules() =
  for i in 1 .. 1000000:
    let
      smi = "c1ccccc1C(=O)NC2CC2" # cyclopropyl benzamide
      m = molFromSmiles(smi)
      q = molFromSmiles("C1CC1")

    if m.ok:
      let
        na = m.numAtoms
        matches = m.substructMatches(q)
        # match = m.hasSubStructMatch(q)

when isMainModule:
  echo getOccupiedMem()
  createLotsOfMolecules()
  # GC_fullCollect()
  echo getOccupiedMem()

