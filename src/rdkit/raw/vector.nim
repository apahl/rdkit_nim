# Taken from https://github.com/kaushalmodi/std_vector/blob/4e953c89e13ebdc1df8b5de71cec04330126b51d/src/std_vector.nim

# https://forum.nim-lang.org/t/3401
type
  CppVector*[T] {.importcpp: "std::vector", header: "<vector>".} = object
  # https://nim-lang.github.io/Nim/manual.html#importcpp-pragma-importcpp-for-objects

  CppPair*[T, U] {.importcpp: "std::pair", header: "<vector>".} = object

  CppIntPair* = CppPair[cint, cint]

  SizeType* = uint

proc first*[T, U](this: CppPair[T, U]): T {.importcpp: "#.first",
    header: "<vector>".}

proc second*[T, U](this: CppPair[T, U]): U {.importcpp: "#.second",
    header: "<vector>".}

proc destroyVector*(this: CppVector) {.importcpp: "#.~vector()",
    header: "<vector>".}

proc len*(v: CppVector): SizeType {.importcpp: "#.size()",
    header: "<vector>".}

proc isEmpty*(v: CppVector): bool {.importcpp: "empty", header: "<vector>".}

proc `[]`*[T](v: CppVector[T], idx: SizeType): var T {.importcpp: "#[#]",
    header: "<vector>".}

iterator items*[T](v: CppVector[T]): T =
  ## Iterate over all the elements in CppVector ``v``.
  for idx in 0.SizeType ..< v.len():
    yield v[idx]

proc toSeq*[T](v: CppVector[T]): seq[T] =
  ## Convert a CppVector to a sequence.
  for elem in v:
    result.add(elem)

proc `$`*[T](v: CppVector[T]): string {.noinit.} =
  ## The ``$`` operator for CppVector type variables.
  ## This is used internally when calling ``echo`` on a CppVector type variable.
  if v.isEmpty():
    result = "v[]"
  else:
    result = "v["
    for idx in 0.SizeType ..< v.size()-1:
      result.add($v[idx] & ", ")
    result.add($v.last() & "]")

proc `$`*(p: CppIntPair): string =
  result = "Pair[fst: " & $p.first & ", snd: " & $p.second & "]"
