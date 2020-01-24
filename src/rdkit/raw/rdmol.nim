# raw/rdmol.nim

import os # `/`, getEnv

const
  condaPath = getEnv("RDKIT_NIM_CONDA")
  smilesHeader = condaPath / "include/rdkit/GraphMol/SmilesParse/SmilesParse.h"
  writerHeader = condaPath / "include/rdkit/GraphMol/SmilesParse/SmilesWrite.h"
  molHeader = condaPath / "include/rdkit/GraphMol/GraphMol.h"

type
  CppString* {.importcpp: "std::string", header: "<string>".} = object

  RdkitSmilesParserParams* {.header: smilesHeader,
                      importcpp: "struct RDKit::SmilesParserParams",
                          bycopy.} = object
  RWMol* {.final, header: molHeader,
    importcpp: "RDKit::RWMol".} = object
  ROMol* {.final, header: molHeader,
    importcpp: "RDKit::ROMol".} = object


proc constructString*(s: cstring): CppString {.header: "<string>",
                                                  importcpp: "std::string(@)", constructor.}

proc cStr*(s: CppString): cstring {.header: "<string>", importcpp: "#.c_str()".}

proc rdkitConstructSmilesParserParams*(): RdkitSmilesParserParams {.
    importcpp: "RDKit::SmilesParserParams()", header: smilesHeader.}

proc destroyROMol*(this: ROMol) {.importcpp: "#.~ROMol()",
    header: molHeader.}

proc newMol*(): ROMol {.constructor, importcpp: "RDKit::ROMol(@)",
    header: molHeader.}
proc rdkitSmilesToMol*(smi: CppString; params: RdkitSmilesParserParams): ptr ROMol {.
    header: smilesHeader, importcpp: "RDKit::SmilesToMol(@)".}

proc rdkitSmartsToMol*(sma: CppString): ptr ROMol {.header: smilesHeader,
    importcpp: "RDKit::SmartsToMol(@)".}

proc rdkitMolToSmiles*(mol: ROMol): CppString {.
    importcpp: "RDKit::MolToSmiles(@)", header: writerHeader.}
