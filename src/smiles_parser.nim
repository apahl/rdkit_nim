import rdmol

const
  srcPath = "/home/pahl/anaconda3/envs/chem/include/rdkit/GraphMol/SmilesParse/"
  srcSmiles = "SmilesParse.h"

type
  CppString* {.importcpp: "std::string", header: "<string>".} = object

  SmilesParserParams* {.header: srcPath & srcSmiles,
                      importcpp: "struct RDKit::SmilesParserParams",
                          bycopy.} = object

proc constructString*(s: cstring): CppString {.header: "<string>",
                                                  importcpp: "std::string(@)", constructor.}

proc constructSmilesParserParams*(): SmilesParserParams {.
    importcpp: "RDKit::SmilesParserParams()", header: srcPath & srcSmiles.}

proc smilesToMol*(smi: CppString; params: ptr): ptr RWMol {.
  header: srcPath & srcSmiles, importcpp: "RDKit::SmilesToMol(@)".}
