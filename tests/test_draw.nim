import
  strutils, # `in` for string
  rdkit / private / test_helpers, # directWrite, rpad
  rdkit / [molecule, draw]

when isMainModule:
  directWrite rpad("    [draw.nim]", 25) & "...\r"
  # testing simple graph formation
  let
    smi = "c1ccccc1C(=O)NC"
    mol1 = molFromSmiles(smi)

  if mol1.ok:
    # The coordinates in the SVG may change,
    # so we check only for the most basic things.
    let svg = mol1.toSVG
    assert "<?xml version='1.0'" in svg
    assert "<svg version='1.1'" in svg
    assert "</svg>" in svg

  echo rpad("    [draw.nim]", 25) & "passed."
