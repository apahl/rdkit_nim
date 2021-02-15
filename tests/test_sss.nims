import os # `/`

let
  fileName = "test_sss"
  condaPath = getEnv("RDKIT_CONDA")

task build, "Building default cpp target...":
  switch("verbosity", "0")
  switch("hints", "off")
  switch("out", "tests/bin" / toExe(fileName))
  switch("run")
  setcommand "cpp"
