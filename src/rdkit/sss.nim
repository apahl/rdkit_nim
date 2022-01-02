# sss.nim

import raw / [cpptypes, rdsss]
import molecule

type Int = int # torn between using `int` or `uint`


using
  self: Mol

proc hasSubStructMatch*(self; query: Mol): bool =
  ## Returns true when the query was found.
  let matches = rdkitSubstructMatch(self.obj[], query.obj[])
  not matches.isEmpty

proc numSubstructMatches*(self; query: Mol): Int =
  ## Returns the number of substructure matches.
  let matches = rdkitSubstructMatch(self.obj[], query.obj[])
  Int(len(matches))

proc substructMatches*(self; query: Mol): seq[seq[Int]] =
  # returns atom indices in the mol that match the query as seq of seq.
  let matches = rdkitSubstructMatch(self.obj[], query.obj[])
  if matches.isEmpty:
    return result
  for match in matches:
    var m: seq[Int]
    for pair in match:
      m.add(Int(pair.second))
    result.add(m)

proc deleteSubstructs*(self; query: Mol): Mol =
  let m = rdkitDeleteSubstructs(self.obj[], query.obj[])
  result.obj = m
