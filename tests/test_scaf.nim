import
  rdkit/private/test_helpers, # directWrite, rpad
  rdkit / [molecule, scaffolds]

when isMainModule:
  directWrite rpad("    [scaffolds.nim]", 25) & "...\r"

  block:
    # Murcko mol from mol
    let
      smi = "c1ccccc1C(=O)NC" # methyl benzamide
      mol = molFromSmiles(smi)
      murcko = murckoMol(mol)
      murckoSmiles = murcko.toSmiles()
    assert mol.ok
    assert murckoSmiles == "c1ccccc1"

  block:
    let
      smi = "O=C(O)Cc1c[nH]c2ccccc12" # indole acetic acid
      mol = molFromSmiles(smi)
      murcko = murckoMol(mol)
      murckoSmiles = murcko.toSmiles()
    assert mol.ok
    assert murckoSmiles == "c1ccc2[nH]ccc2c1"

  block:
    # Murcko Smiles directly from Smiles
    let
      smi = "O=C(O)Cc1c[nH]c2ccccc12" # indole acetic acid
      murckoSmiles = smi.murckoSmiles()
    assert murckoSmiles == "c1ccc2[nH]ccc2c1"

  block:
    # Murcko Smiles directly from Smiles
    # raise on invalid Smiles
    let smi = "xxx"
    try:
      discard smi.murckoSmiles(ignoreInvalid = false)
      assert false
    except ValueError:
      assert true

  block:
    # Murcko Smiles directly from Smiles
    # ignore invalid
    let
      smi = "xxx"
      murckoSmiles = smi.murckoSmiles(ignoreInvalid = true)
    assert murckoSmiles == ""


  echo rpad("    [scaffolds.nim]", 25) & "passed."
