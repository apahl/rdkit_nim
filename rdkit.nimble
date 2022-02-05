# Package rdkit

version       = "0.1.0"
author        = "Axel Pahl"
description   = "Bindings for the C++ cheminformatics toolkit RDKit"
license       = "MIT"
srcDir        = "src"

backend       = "cpp"

# Dependencies

requires "nim >= 1.4"

import os, algorithm

task test, "run tests":
  # test files have to be in dir `tests` and of the form `test_xxx.nim`
  # list tests that should be skipped here, e.g. during development,
  # when they have already been run.
  # let testsToSkip = @["test_xxx"]
  let testsToSkip = @[
    "test_mol", "test_sss", "test_qed", "test_draw"
  ]
  var skippedTests: seq[string]
  mkDir "tests/bin"
  var failed = false
  for f in sorted(listFiles("tests")):
    if f[0..10] == "tests/test_" and f[^4..^1] == ".nim":
      let testName = f[6..^5]
      if testName in testsToSkip:
        skippedTests.add(testName)
        continue
      let runCmd = "LD_LIBRARY_PATH=$RDKIT_CONDA/lib nim --hint[Conf]:off -f build tests/" & testName & ".nim 2> tests/bin/" & testName & ".out"
      try:
        exec runCmd
      except:
        failed = true
      if failed:
        echo "Failed to run " & f
        echo "More information can be found in tests/bin/" & testName & ".out"
        break
  if not failed:
    echo "\n    All tests passed."
    rmDir "tests/bin/"
  if skippedTests.len  > 0:
    echo "\n  Skipped tests:"
    for st in skippedTests:
      echo "    - ", st

task docs, "generate documentation":
  echo "    generating documentation..."
  mkDir "docs"
  for file in listFiles("src/rdkit/"):
    if splitFile(file).ext == ".nim":
      let taskCmd = "LD_LIBRARY_PATH=$RDKIT_CONDA/lib nim doc --index:on --verbosity:0 --hints:off -o:" & "docs" /../ file.changeFileExt("html").split("/")[2] & " " & file
      exec taskCmd
      exec "nim buildIndex --verbosity:0 --hints:off -o:docs/theindex.html docs"
