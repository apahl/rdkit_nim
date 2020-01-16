# Package

version       = "0.1.0"
author        = "Axel Pahl"
description   = "Bindings to the C++ cheminformatics toolkit RDKit"
license       = "MIT"
srcDir        = "src"

backend       = "cpp"

# Dependencies

requires "nim >= 1.1.1"

task test, "run tests...":
  # test files have to be in dir `tests` and of the form `test_xxx.nim`
  # list tests that should be skipped here, e.g. during development,
  # when they have already been run.
  let testsToSkip = @["test_xxx"]
  var skippedTests: seq[string]
  mkDir "tests/bin"
  for f in listFiles("tests"):
    if f[0..10] == "tests/test_" and f[^4..^1] == ".nim":
      let testName = f[6..^1]
      if testName in testsToSkip:
        skippedTests.add(testName)
        continue
      let runCmd = "LD_LIBRARY_PATH=$RDKIT_NIM_CONDA/lib nim --hint[Conf]:off build tests/" & testName
      var failed = false
      try:
        exec runCmd
      except:
        failed = true
        echo "Failed to run " & f
      if failed:
        break
  if skippedTests.len  > 0:
    echo "\n  Skipped tests:"
    for st in skippedTests:
      echo "    - ", st
  rmDir "tests/bin/"