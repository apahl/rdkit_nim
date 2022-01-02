import os # `/`

let
  fileName = "ex04_nil"

task build, "Building default cpp target...":
  switch("out", "bin" / toExe(fileName))
  setcommand "cpp"

task buildRelease, "Building release cpp target...":
  switch("define", "release")
  switch("out", "bin" / toExe(fileName))
  setcommand "cpp"
