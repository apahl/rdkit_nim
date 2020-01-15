# smiles_parser.nim

import raw/smiles_parser
import mol

proc smilesToMol*(smi: string): Mol =
  result = new Mol
  let
    cstr = smi.cstring
    s = constructString(cstr)
    p = RdkitSmilesParserParams()
    m = rdkitSmilesToMol(s, p)
  result.obj = m
