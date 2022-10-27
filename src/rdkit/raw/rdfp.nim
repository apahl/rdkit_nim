# raw/rdscaf.nim

import os # `/`, getEnv RDKIT_CONDA

import ./rdmol

const
  condaPath = getEnv("RDKIT_CONDA")
  morganHeader = condaPath / "include/rdkit/GraphMol/Fingerprints/MorganFingerprints.h"

{.passL: "-lRDKitFingerprints".}

type
  RDSparseVect*[T] {.final, header: morganHeader,
    importcpp: "RDKit::SparseIntVect".} = object
  RDSparseIntVect* = RDSparseVect[cuint]

proc rdkitMorganFingerprint*(this: ROMol;
    radius: cuint): ptr RDSparseIntVect {.
    importcpp: "RDKit::MorganFingerprints::getFingerprint(@)",
        header: morganHeader.}

proc rdkitTanimotoSim*(v1, v2: RDSparseIntVect): cdouble {.
    importcpp: "RDKit::TanimotoSimilarity(@)",
        header: morganHeader.}
