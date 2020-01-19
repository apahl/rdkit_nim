import os # `/`

let
  fileName = "test_lipinski"
  condaPath = getEnv("RDKIT_NIM_CONDA")

task build, "Building default cpp target...":
  switch("verbosity", "0")
  # switch("hint[Conf]", "off")
  switch("hints", "off")
  switch("out", "tests/bin" / toExe(fileName))
  switch("run")
  switch("passL", "-lstdc++")
  switch("passL", "-L" & condaPath & "/lib")
  switch("passL", "-lRDKitGraphMol")
  switch("passL", "-lRDKitDescriptors")
  switch("passL", "-lRDKitSmilesParse")
  switch("passL", "-lRDKitSubstructMatch")
  switch("cincludes", condaPath & "/include/rdkit")
  switch("cincludes", condaPath & "/include")
  setcommand "cpp"
