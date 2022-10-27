import
  rdkit/private/test_helpers, # directWrite, rpad
  rdkit / [molecule, fingerprints]

when isMainModule:
  directWrite rpad("    [fingerprints.nim]", 25) & "...\r"

  block:
    let
      smi1 = "c1ccccc1C(=O)NC"
      mol1 = molFromSmiles(smi1)
      fp1 = morganFP(mol1, 2)

      smi2 = "c1ccccc1"
      mol2 = molFromSmiles(smi2)
      fp2 = morganFP(mol2, 2)


    # echo tanimotoSim(fp1, fp2)
    let taniSim = tanimotoSim(fp1, fp2)
    assert equalFloats(taniSim, 0.24324)

  echo rpad("    [fingerprints.nim]", 25) & "passed."
