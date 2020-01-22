import
  rdkit/private/test_helpers, # directWrite, rpad
  rdkit / [mol, parsers]

when isMainModule:
  directWrite rpad("    [parsers.nim]", 25) & "...\r"
  # testing simple graph formation
  let
    smi = "c1ccccc1C(=O)NC"
    m = molFromSmiles(smi)


  assert m.ok
  assert m.numAtoms == 10
  assert equalFloats(m.molWt, 135.166)
  assert m.molToSmiles == "CNC(=O)c1ccccc1"

  echo rpad("    [parsers.nim]", 25) & "passed."
