# raw/rdmol.nim

import os # `/`, getEnv
import ./cpptypes

const
  condaPath = getEnv("RDKIT_CONDA")
  smilesHeader = condaPath / "include/rdkit/GraphMol/SmilesParse/SmilesParse.h"
  writerHeader = condaPath / "include/rdkit/GraphMol/SmilesParse/SmilesWrite.h"
  molBlockHeader = condaPath / "include/rdkit/GraphMol/FileParsers/FileParsers.h"
  molHeader = condaPath / "include/rdkit/GraphMol/GraphMol.h"
  opsHeader = condaPath / "include/rdkit/GraphMol/MolOps.h"

{.passL: "-L" & condaPath & "/lib".}
{.passL: "-lRDKitGraphMol".}
{.passL: "-lRDKitSmilesParse".}
{.passL: "-lRDKitFileParsers".}

{.passC: "-I" & condaPath & "/include".}
{.passC: "-I" & condaPath & "/include/rdkit".}

type
  RdkitSmilesParserParams* {.header: smilesHeader,
                      importcpp: "struct RDKit::SmilesParserParams",
                          bycopy.} = object
  RWMol* {.final, header: molHeader,
    importcpp: "RDKit::RWMol".} = object
  ROMol* {.final, header: molHeader,
    importcpp: "RDKit::ROMol".} = object


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

proc rdkitMolToMolBlock*(mol: ROMol): CppString {.
    importcpp: "RDKit::MolToMolBlock(@)", header: molBlockHeader.}

proc rdkitRemoveHs*(mol: ROMol): ptr ROMol {.
    importcpp: "RDKit::MolOps::removeHs(@)", header: opsHeader.}
