# smiles_parser.nim

import raw/rdparsers
import mol

proc smilesToMol*(smi: string): Mol =
  # result = new Mol
  let
    cstr = smi.cstring
    s = constructString(cstr)
    p = RdkitSmilesParserParams()
    m = rdkitSmilesToMol(s, p)
  result.obj = m

proc smartsToMol*(sma: string): Mol =
  # result = new Mol
  let
    cstr = sma.cstring
    s = constructString(cstr)
    m = rdkitSmartsToMol(s)
  result.obj = m


