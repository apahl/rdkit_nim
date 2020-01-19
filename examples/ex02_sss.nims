import os # `/`

let
  fileName = "ex02_sss"
  condaPath = getEnv("RDKIT_NIM_CONDA")

task build, "Building default cpp target...":
  switch("out", "bin" / toExe(fileName))
  switch("passL", "-lstdc++")
  switch("passL", "-L" & condaPath & "/lib")
  switch("passL", "-lRDKitGraphMol")
  switch("passL", "-lRDKitDescriptors")
  switch("passL", "-lRDKitSmilesParse")
  switch("passL", "-lRDKitSubstructMatch")
  switch("cincludes", condaPath & "/include/rdkit")
  switch("cincludes", condaPath & "/include")
  setcommand "cpp"
