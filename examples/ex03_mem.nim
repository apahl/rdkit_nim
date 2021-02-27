import rdkit / [molecule, descriptors, sss]
import os

proc createLotsOfMolecules() =
  for i in 1 .. 1000000:
    var
      smi = "c1ccccc1C(=O)NC2CC2" # cyclopropyl benzamide
      m = molFromSmiles(smi)
      q = molFromSmiles("C1CC1")

    let
      na = m.numAtoms
      matches = m.substructMatches(q)
      # match = m.hasSubStructMatch(q)
    # m.destroy
    # q.destroy

when isMainModule:
  echo getOccupiedMem()
  createLotsOfMolecules()
  # GC_fullCollect()
  echo getOccupiedMem()
  sleep(20000)
