# Package

version       = "0.1.0"
author        = "Axel Pahl"
description   = "Bindings for the C++ cheminformatics toolkit RDKit"
license       = "MIT"
srcDir        = "src"

backend       = "cpp"

# Dependencies

requires "nim >= 1.1.1"

import os, algorithm

task test, "run tests":
  # test files have to be in dir `tests` and of the form `test_xxx.nim`
  # list tests that should be skipped here, e.g. during development,
  # when they have already been run.
  let testsToSkip = @["test_xxx"]
  var skippedTests: seq[string]
  mkDir "tests/bin"
  var failed = false
  for f in sorted(listFiles("tests")):
    if f[0..10] == "tests/test_" and f[^4..^1] == ".nim":
      let testName = f[6..^1]
      if testName in testsToSkip:
        skippedTests.add(testName)
        continue
      let runCmd = "LD_LIBRARY_PATH=$RDKIT_NIM_CONDA/lib nim --hint[Conf]:off -f build tests/" & testName
      try:
        exec runCmd
      except:
        failed = true
        echo "Failed to run " & f
      if failed:
        break
  if not failed:
    echo "\n    All tests passed."
  if skippedTests.len  > 0:
    echo "\n  Skipped tests:"
    for st in skippedTests:
      echo "    - ", st
  rmDir "tests/bin/"

task doc, " generate documentation":
  echo "    generating documentation..."
  mkDir "docs"
  for file in listFiles("src/rdkit/"):
    if splitFile(file).ext == ".nim":
      let taskCmd = "nim doc --index:on --verbosity:0 --hints:off -o:" & "docs" /../ file.changeFileExt("html").split("/")[2] & " " & file
      echo taskCmd
      exec taskCmd
      exec "nim buildIndex --verbosity:0 --hints:off -o:docs/theindex.html docs"
