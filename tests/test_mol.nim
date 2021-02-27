import
  strutils, # `in` for string
  rdkit / private / test_helpers, # directWrite, rpad
  rdkit / [molecule, descriptors]

when isMainModule:
  directWrite rpad("    [mol.nim]", 25) & "...\r"
  # testing simple graph formation
  let
    smi = "c1ccccc1C(=O)NC"
    mol1 = molFromSmiles(smi)
    smi2 = "c1ccccc1C(=O)NC2CC2" # cyclopropyl benzamide
    mol2 = molFromSmiles(smi2)
    noMol = molFromSmiles("xxx")
    defMol = molDefault()

  assert noMol.isNil
  assert mol1.ok

  if mol1.ok:
    assert mol1.numAtoms == 10
    assert equalFloats(mol1.molWt, 135.166)
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

  assert defMol.numAtoms == 1
  assert defMol.molWt == 0.0

  echo rpad("    [mol.nim]", 25) & "passed."
