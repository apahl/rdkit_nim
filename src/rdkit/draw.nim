# draw.nim

import ./raw/cpptypes
import ./raw/rddraw
import molecule

type CoordGenMethod* = enum
  RDKit,
  CoordGen

proc toSVG*(mol: Mol, width = 300, height = 200,
    coordGen: CoordGenMethod = CoordGen): string =
  if coordGen == CoordGen:
    rdkitPreferCoordGen(true)
  else:
    rdkitPreferCoordGen(false)
  var drawer = rdkitConstructMolDraw2DSVG(width.cint, height.cint)
  drawer.rdkitDrawMol(mol.obj[])
  drawer.rdkitDrawFinish()
  let cppSvg = drawer.rdkitDrawGetText()
  result = $cppSvg.cStr
  # result = "Test"
