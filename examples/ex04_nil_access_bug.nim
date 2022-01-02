# The ga_optimize program crashes with random nil access errors.
# This is an attempt to reproduce these errors and find the cause.

import rdkit / [molecule, sss, qed]
import os
import random

var unwanted: seq[Mol]
for smi in [
  "C1=CC=1", # "cyclopropadiene"
  "C1=CC1", # "cyclopropene"
  "C1=CC=C1", # "cyclobutadiene1"
  "C1=CCC1", # "cyclobutene"
]:
  unwanted.add(molFromSmiles(smi))

proc tryToHitTheBug() =
  var m: Mol
  for i in 1 .. 100000:
    var
      # smi = "CN(C)c5ccc(CN3C(=O)c2cc(c1ccC(=O)OC(=O)Occc1)nn2CC3(C)C(=O)NCc4ccccc4)cc5"
      smi = "CN(C)c5ccc(CN3C(=O)c2cc(c1ccc(O)c=c1)nn2CC3(C)C(=O)NCc4ccccc4)cc5"
    m = molFromSmiles(smi)

    for q in unwanted:
      let match = m.hasSubStructMatch(q)
      if match:
        echo "ShouldNotReach"

    sleep(rand(50))
    let qv = qedDefault(m)
    if qv > 10.0:
      echo "ShouldNotReach"
    # m.destroy
    # q.destroy

when isMainModule:
  echo getOccupiedMem()
  tryToHitTheBug()
  # GC_fullCollect()
  echo getOccupiedMem()
  sleep(20000)
