import
  tables,
  strutils,
  rdkit/private/test_helpers, # directWrite, rpad
  rdkit / [mol, qed]

when isMainModule:
  directWrite rpad("    [qed.nim]", 25) & "...\r"

  let
    # Define TestSet of Smiles and expected QED values (calculated by the Python bindings):
    testSet: Table[string, float] = {
      "CN(C)c5ccc(-N3C(=O)c2cc(c1ccc(=O)c1)nCn2C3(C)C(=O)Nc4ccccc4)cc5": 0.73051,
      "CN1CCN(Cc2ccc(cc2)C(=O)Nc3ccc(C)c(Nc4nccc(n4)c5cccnc5)c3)CC1": 0.389416,
      "O=C(Nc1cccc(Nc2cc(Nc3cccc(C(F)(F)F)c3)ncn2)c1)C1CC1": 0.50903068,
      "C=CC12CN(C)C3CC14C(=Nc1ccccc14)C1CC2C3CO1": 0.745320,
      "C/C=C(/C)C(=O)O[C@H]1c2cc3c(c(OC)c2-c2c(cc4c(c2OC)OCO4)[C@H](OC(C)=O)[C@H](C)[C@]1(C)O)OCO3": 0.416073568,
      "COc1cc2c(c(O)c1CCO)COC2=O": 0.7353680,
    }.toTable

  for smi, e in testSet.pairs:
    let m = molFromSmiles(smi)
    assert(m.ok, "Could not generate mol from Smiles $1" % [smi])
    let a = qedDefault(m)
    assert(equalFloats(a, e), "QED $1 did not match the expected value $2 for Smiles $3" %
        [$a, $e, smi])

  echo rpad("    [qed.nim]", 25) & "passed."
