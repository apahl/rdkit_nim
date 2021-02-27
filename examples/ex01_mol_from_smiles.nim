import rdkit / [molecule, descriptors, draw]

when isMainModule:
  let
    smi = "c1ccccc1C(=O)NC"
    mol = molFromSmiles(smi)

  echo "Mol Ok:            ", mol.ok

  if mol.ok:
    let
      na = mol.numAtoms
      mw = mol.molWt
      rot = mol.numRotatableBonds
      nh = mol.numHeteroAtoms
    echo "Num Atoms:         ", na
    echo "Mol weight:        ", mw
    echo "Rot. Bonds:        ", rot
    echo "Num HetAtoms:      ", nh
    echo "Canonical Smiles:  ", mol.toSmiles
    echo "TPSA:              ", mol.tPSA
    echo "SSSR:              ", mol.findSSSR
    echo "MolBlock: "
    echo mol.toMolBlock
    echo "SVG (CoordGen):"
    echo mol.toSVG(coordGen = CoordGen)
    echo "SVG (RDKit):"
    echo mol.toSVG(coordGen = RDKit)
