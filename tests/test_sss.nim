import
  rdkit/private/test_helpers, # directWrite, rpad
  rdkit / [molecule, descriptors, sss]

when isMainModule:
  directWrite rpad("    [sss.nim]", 25) & "...\r"
  let
    smi = "c1ccccc1C(=O)NC2CC2"      # cyclopropyl benzamide
    mol1 = molFromSmiles(smi)
    query1 = molFromSmiles("C1CC1")  # cyclopropane
    query2 = molFromSmiles("C1CCC1") # cyclobutane


  assert mol1.ok
  assert query1.ok
  assert query2.ok

  assert mol1.numAtoms == 12

  assert mol1.hasSubStructMatch(query1)
  assert not mol1.hasSubStructMatch(query2)

  assert mol1.numSubstructMatches(query1) == 1
  assert mol1.numSubstructMatches(query2) == 0

  assert mol1.substructMatches(query1) == @[@[9, 10, 11]]



  # delete cylopropyl from cyclopropyl benzamide
  let m2 = deleteSubstructs(mol1, query1)
  assert m2.numAtoms == 9

  echo rpad("    [sss.nim]", 25) & "passed."
