import os # `/`, getEnv

import rdmol

const
  condaPath = getEnv("RDKIT_NIM_CONDA")
  smilesHeader = condaPath / "include/rdkit/GraphMol/SmilesParse/SmilesParse.h"

type
  CppString* {.importcpp: "std::string", header: "<string>".} = object

  SmilesParserParams* {.header: smilesHeader,
                      importcpp: "struct RDKit::SmilesParserParams",
                          bycopy.} = object

proc constructString*(s: cstring): CppString {.header: "<string>",
                                                  importcpp: "std::string(@)", constructor.}

proc constructSmilesParserParams*(): SmilesParserParams {.
    importcpp: "RDKit::SmilesParserParams()", header: smilesHeader.}

proc smilesToMol*(smi: CppString; params: ptr): ptr RWMol {.
  header: smilesHeader, importcpp: "RDKit::SmilesToMol(@)".}
