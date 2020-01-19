# raw/rdsss.nim

import os # `/`, getEnv RDKIT_NIM_CONDA

import ./vector
import ./rdmol

const
  condaPath = getEnv("RDKIT_NIM_CONDA")
  sssHeader = condaPath / "include/rdkit/GraphMol/Substruct/SubstructMatch.h"

type
  RdMatchVector* = CppVector[CppIntPair]

proc rdkitSubstructMatch*(this: ROMol; query: ROMol): CppVector[CppVector[
    CppIntPair]] {.importcpp: "RDKit::SubstructMatch(@)", header: sssHeader.}

# proc isEmpty*(m: CppVector[CppVector[CppIntPair]]): bool = m.isEmpty

