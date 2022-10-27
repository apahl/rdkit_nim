# raw/rdfp.nim

import os # `/`, getEnv RDKIT_CONDA

import ./rdmol

const
  condaPath = getEnv("RDKIT_CONDA")
  transformHeader = condaPath / "include/rdkit/GraphMol/ChemTransforms/ChemTransforms.h"

{.passL: "-lRDKitChemTransforms".}

proc rdkitMurckoDecompose*(this: ROMol): ptr ROMol {.
    importcpp: "RDKit::MurckoDecompose(@)", header: transformHeader.}
