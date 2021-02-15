import os # `/`

let
  fileName = "ex01_mol_from_smiles"

task build, "Building default cpp target...":
  switch("out", "bin" / toExe(fileName))
  setcommand "cpp"
