# raw/rdsss.nim

import os # `/`, getEnv RDKIT_NIM_CONDA

import ./vector
import ./rdmol

const
  condaPath = getEnv("RDKIT_NIM_CONDA")
  sssHeader = condaPath / "include/rdkit/GraphMol/Substruct/SubstructMatch.h"
  transformHeader = condaPath / "include/rdkit/GraphMol/ChemTransforms/ChemTransforms.h"

type
  RdMatchVector* = CppVector[CppIntPair]

proc rdkitSubstructMatch*(this: ROMol; query: ROMol): CppVector[CppVector[
    CppIntPair]] {.importcpp: "RDKit::SubstructMatch(@)", header: sssHeader.}

proc rdkitDeleteSubstructs*(this: ROMol; query: ROMol): ptr ROMol {.
    importcpp: "RDKit::deleteSubstructs(@)", header: transformHeader.}

