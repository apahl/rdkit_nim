# fingerprints.nim

import ./raw/rdfp
import molecule

type
  ## The base Mol object
  SparseIntVect* = object
    obj*: ptr RDSparseIntVect

using
  this: Mol

proc morganFP*(this; radius: uint = 2): SparseIntVect =
  let fp = rdkitMorganFingerprint(this.obj[], radius.cuint)
  result.obj = fp

proc tanimotoSim*(v1, v2: SparseIntVect): float =
  result = rdkitTanimotoSim(v1.obj[], v2.obj[]).float
