# nm -gC libRDKitGraphMol.so | less
# /home/pahl/anaconda3/envs/chem/lib/libRDKitGraphMol.so.1.2019.09.2
import os # `/`, getEnv RDKIT_NIM_CONDA

const
  condaPath = getEnv("RDKIT_NIM_CONDA")
  molHeader = condaPath / "include/rdkit/GraphMol/GraphMol.h"

type
  RWMol* {.final, header: molHeader,
    importcpp: "RDKit::RWMol".} = object

  ROMol* {.final, header: molHeader,
    importcpp: "RDKit::ROMol".} = object

proc newMol*(): RWMol {.constructor, importcpp: "RDKit::RWMol(@)",
   header: molHeader.}

proc numAtoms*(this: RWMol): cuint {.importcpp: "#.getNumAtoms(@)",
  header: molHeader.}

