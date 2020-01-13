import ../src/rdmol
import ../src/smiles_parser

when isMainModule:
  var
    sp = "c1ccccc1".cstring

    s = constructString(sp)
    # p = constructSmilesParserParams()
    p = SmilesParserParams()
    m = smilesToMol(s, addr p)
    na = m[].numAtoms()

  echo "Num Atoms: ", na
