# nm -gC libRDKitGraphMol.so | less
# /home/pahl/anaconda3/envs/chem/lib/libRDKitGraphMol.so.1.2019.09.2
const
  srcPath = "/home/pahl/anaconda3/envs/chem/include/rdkit/GraphMol/"
  srcMol = "GraphMol.h"

type
  RWMol* {.final, header: srcPath & srcMol,
    importcpp: "RDKit::RWMol".} = object

  ROMol* {.final, header: srcPath & srcMol,
    importcpp: "RDKit::ROMol".} = object

proc newMol*(): RWMol {.constructor, importcpp: "RDKit::RWMol(@)",
   header: srcPath & srcMol.}

proc numAtoms*(this: RWMol): cuint {.importcpp: "#.getNumAtoms(@)",
  header: srcPath & srcMol.}

