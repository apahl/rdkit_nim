import
  ../src/rdkit/private/test_helpers, # directWrite, rpad
  ../src/rdkit / [mol, parsers]

when isMainModule:
  directWrite rpad("    [mol.nim]", 25) & "...\r"
  # testing simple graph formation
  let
    smi = "c1ccccc1C(=O)NC"
    m = smilesToMol(smi)


  assert m.ok
  assert m.numAtoms == 10
  assert equalFloats(m.molWt, 135.166)
  assert m.numRotatableBonds == 1
  assert m.numHeteroAtoms == 2
  assert m.numHBD == 1
  assert m.numHBA == 1
  assert equalFloats(m.cLogP, 1.0462)
  assert equalFloats(m.fractionCSP3, 0.125)

  echo rpad("    [mol.nim]", 25) & "all tests passed."
