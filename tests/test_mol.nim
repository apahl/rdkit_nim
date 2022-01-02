import
  strutils, # `in` for string
  rdkit / private / test_helpers, # directWrite, rpad
  rdkit / [molecule, descriptors]

when isMainModule:
  directWrite rpad("    [mol.nim]", 25) & "...\r"
  # testing simple graph formation
  let
    smi1 = "c1ccccc1C(=O)NC"
    mol1 = molFromSmiles(smi1)
    smi2 = "c1ccccc1C(=O)NC2CC2"                        # cyclopropyl benzamide
    mol2 = molFromSmiles(smi2)
    mol3 = molFromSmiles("NC(Cc1c[nH]c2ccccc12)C(=O)O") # (+/-)-tryptophane
    noMol1 = molFromSmiles("xxx")
    noMol2 = molFromSmiles("c1cccc1(=O)N")              # invalid: 5-membered ring!
    defMol = molDefault()

  assert noMol1.isNil
  assert noMol2.isNil
  assert mol1.ok

  if mol1.ok:
    assert mol1.numAtoms == 10
    assert equalFloats(mol1.avgMolWt, 135.166)
    assert equalFloats(mol1.exactMolWt, 135.0684139)
    assert mol1.numRotatableBonds == 1
    assert mol1.numHeteroAtoms == 2
    assert mol1.numHBD == 1
    assert mol1.numHBA == 1
    assert equalFloats(mol1.cLogP, 1.0462)
    assert equalFloats(mol1.fractionCSP3, 0.125)
    assert equalFloats(mol1.tPSA, 29.1)
    assert mol1.toSmiles == "CNC(=O)c1ccccc1"

    # The coordinates in the MolBlock may change,
    # so we check only for the most basic things.
    let ctab = mol1.toMolBlock
    assert "RDKit" in ctab
    assert "M  END" in ctab

  assert findSSSR(mol2) == 2

  # RingAtoms
  let ringAtoms = mol2.ringAtoms
  assert ringAtoms.len == 2
  assert ringAtoms[0].len == 3 or ringAtoms[0].len == 6
  assert ringAtoms[1].len == 3 or ringAtoms[1].len == 6
  assert ringAtoms[0].len + ringAtoms[1].len == 9

  assert mol3.largestRing == 6 # tryptophane
  assert mol3.numRingsSizeGE(5) == 2
  assert mol2.numRingsSizeGE(6) == 1 # cyclopropyl benzamide

  assert defMol.numAtoms == 1
  assert defMol.avgMolWt == 0.0

  echo rpad("    [mol.nim]", 25) & "passed."
