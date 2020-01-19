# sss.nim

import raw / [vector, rdsss]
import mol

using
  this: Mol

proc hasSubStructMatch*(this; query: Mol): bool =
  ## Returns true when the query was found.
  not rdkitSubstructMatch(this[], query[]).isEmpty

proc numSubstructMatches*(this; query: Mol): uint =
  ## Returns the number of substructure matches.
  len(rdkitSubstructMatch(this[], query[]))

proc substructMatches*(this; query: Mol): seq[seq[uint]] =
  # returns atom indices in the mol that match the query as seq of seq.
  let matches = rdkitSubstructMatch(this[], query[])
  if matches.isEmpty:
    return result
  for match in matches:
    var m: seq[uint]
    for pair in match:
      m.add(uint(pair.second))
    result.add(m)

