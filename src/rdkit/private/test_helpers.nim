## Helper functions for testing

## buffer-free writing to stdout
template directWrite*(s: string): untyped =
  stdout.write s
  stdout.flushFile

## compare two doubles with a tolerance
proc equalFloats*(d1, d2: float; floatCutoff = 1.0e-4): bool =
  abs(d1 - d2) < floatCutoff

## right-pad a string
proc rpad*(s: string; n: int): string =
  let p = "                      "
  result = s
  let np = n - result.len
  if np > 0:
    result = result & p[0..np]
