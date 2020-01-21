import
  ../src/rdkit/private/test_helpers, # directWrite, rpad
  ../src/rdkit / [mol, parsers, sss]

when isMainModule:
  directWrite rpad("    [sss.nim]", 25) & "...\r"
  let
    smi = "c1ccccc1C(=O)NC2CC2"  # cyclopropyl benzamide
    m = molFromSmiles(smi)
    q1 = molFromSmiles("C1CC1")  # cyclopropane
    q2 = molFromSmiles("C1CCC1") # cyclobutane


  assert m.ok
  assert q1.ok
  assert q2.ok
  assert m.numAtoms == 12

  assert m.hasSubStructMatch(q1)
  assert not m.hasSubStructMatch(q2)

  assert m.numSubstructMatches(q1) == 1
  assert m.numSubstructMatches(q2) == 0

  assert m.substructMatches(q1) == @[@[9.uint, 10, 11]]

  echo rpad("    [sss.nim]", 25) & "passed."
