import os # `/`

let
  fileName = "ex02_sss"

task build, "Building default cpp target...":
  switch("out", "bin" / toExe(fileName))
  setcommand "cpp"
