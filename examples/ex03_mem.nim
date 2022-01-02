import rdkit / [molecule, descriptors, sss]
import os
import random


proc createLotsOfMolecules() =
  for i in 1 .. 100000:
    var
      smi = "c1ccccc1C(=O)NC2CC2" # cyclopropyl benzamide
      m = molFromSmiles(smi)
      q = molFromSmiles("C1=CCC1")

    let na = m.numAtoms
    sleep(rand(50))
    let match = m.hasSubStructMatch(q)
    # m.destroy
    # q.destroy

when isMainModule:
  echo getOccupiedMem()
  createLotsOfMolecules()
  # GC_fullCollect()
  echo getOccupiedMem()
  sleep(20000)
