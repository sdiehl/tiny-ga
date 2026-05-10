import TinyGA.Cl3

open TinyGA Cl3

def main : IO Unit := do
  let v := vec 1.0 1.0 0.0
  IO.println s!"v               = {show3 v}"
  let r1 := reflect e1 v
  IO.println s!"reflect-x v     = {show3 r1}"
  let r2 := reflect e2 v
  IO.println s!"reflect-y v     = {show3 r2}"
  let r12 := reflect e2 (reflect e1 v)
  IO.println s!"reflect-y∘x v   = {show3 r12}"
  let R := rotor e12 TinyGA.pi
  IO.println s!"rotate by pi v  = {show3 (rotate R v)}"
