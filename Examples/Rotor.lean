import TinyGA.Cl3

open TinyGA Cl3

def main : IO Unit := do
  let v := vec 1.0 0.0 0.0
  IO.println s!"v        = {show3 v}"
  let R := rotor e12 (TinyGA.pi / 2.0)
  IO.println s!"R        = {show3 R}"
  let v' := rotate R v
  IO.println s!"R v R~   = {show3 v'}"
  let R45 := rotor e12 (TinyGA.pi / 4.0)
  let R90 := rotate R45 (rotate R45 v)
  IO.println s!"R45 R45  = {show3 R90}"
  let Rz := rotor e23 (TinyGA.pi / 2.0)
  let v3 := rotate Rz (vec 0.0 1.0 0.0)
  IO.println s!"e23·e2   = {show3 v3}"
