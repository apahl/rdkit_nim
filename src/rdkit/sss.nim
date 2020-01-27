# sss.nim

import raw / [vector, rdsss]
import mol

using
  this: Mol

proc hasSubStructMatch*(this; query: Mol): bool =
  ## Returns true when the query was found.
  not rdkitSubstructMatch(this.obj[], query.obj[]).isEmpty

proc numSubstructMatches*(this; query: Mol): uint =
  ## Returns the number of substructure matches.
  len(rdkitSubstructMatch(this.obj[], query.obj[]))

proc substructMatches*(this; query: Mol): seq[seq[uint]] =
  # returns atom indices in the mol that match the query as seq of seq.
  let matches = rdkitSubstructMatch(this.obj[], query.obj[])
  if matches.isEmpty:
    return result
  for match in matches:
    var m: seq[uint]
    for pair in match:
      m.add(uint(pair.second))
    result.add(m)

proc deleteSubstructs*(this; query: Mol): Mol =
  let m = rdkitDeleteSubstructs(this.obj[], query.obj[])
  result.obj = m
