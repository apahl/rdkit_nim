import os # `/`

let
  fileName = "ex03_mem"

task build, "Building default cpp target...":
  switch("out", "bin" / toExe(fileName))
  setcommand "cpp"

task buildRelease, "Building release cpp target...":
  switch("define", "release")
  switch("out", "bin" / toExe(fileName))
  setcommand "cpp"
