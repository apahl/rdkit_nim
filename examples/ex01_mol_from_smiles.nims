import os # `/`

let
  fileName = "ex01_mol_from_smiles"
  condaPath = getEnv("RDKIT_NIM_CONDA")

task build, "Building default cpp target...":
  switch("out", "bin" / toExe(fileName))
  switch("passL", "-lstdc++")
  switch("passL", "-L" & condaPath & "/lib")
  switch("passL", "-lRDKitGraphMol") # needed for `mol`
  switch("passL", "-lRDKitDescriptors") # needed for calculated properties
  switch("passL", "-lRDKitSmilesParse") # needed for `molFromSmiles()`
  switch("cincludes", condaPath & "/include/rdkit")
  switch("cincludes", condaPath & "/include")
  setcommand "cpp"
