# raw/rddesc.nim

# nm -gC libRDKitGraphMol.so | less
# /home/pahl/anaconda3/envs/chem/lib/libRDKitGraphMol

import os # `/`, getEnv RDKIT_NIM_CONDA

import ./rdmol

const
  condaPath = getEnv("RDKIT_NIM_CONDA")
  molHeader = condaPath / "include/rdkit/GraphMol/GraphMol.h"
  descHeader = condaPath / "include/rdkit/GraphMol/Descriptors/MolDescriptors.h"

proc rdkitNumAtoms*(this: ROMol): cuint {.importcpp: "#.getNumAtoms(@)",
    header: molHeader.}

proc rdkitMolWt*(mol: ROMol): cdouble {.
    importcpp: "RDKit::Descriptors::calcAMW(@)", header: descHeader.}

proc rdkitNumHBD*(mol: ROMol): cuint {.importcpp: "RDKit::Descriptors::calcNumHBD(@)",
    header: descHeader.}

proc rdkitNumHBA*(mol: ROMol): cuint {.importcpp: "RDKit::Descriptors::calcNumHBA(@)",
    header: descHeader.}

proc rdkitNumRotatableBonds*(mol: ROMol): cuint {.
    importcpp: "RDKit::Descriptors::calcNumRotatableBonds(@)",
    header: descHeader.}

proc rdkitNumHeteroatoms*(mol: ROMol): cuint {.
    importcpp: "RDKit::Descriptors::calcNumHeteroatoms(@)",
    header: descHeader.}

proc rdkitFractionCSP3*(mol: ROMol): cdouble {.
    importcpp: "RDKit::Descriptors::calcFractionCSP3(@)",
    header: descHeader.}

proc rdkitNumRings*(mol: ROMol): cuint {.
    importcpp: "RDKit::Descriptors::calcNumRings(@)",
    header: descHeader.}

proc rdkitClogP*(mol: ROMol): cdouble {.
    importcpp: "RDKit::Descriptors::calcClogP(@)",
    header: descHeader.}
