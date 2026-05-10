import TinyGA.Cl3

open TinyGA Cl3

def main : IO Unit := do
  IO.println "Pauli algebra emerges from Cl(3,0)."
  IO.println "Vectors {e1,e2,e3} square to +1 like Pauli σi."
  IO.println s!"  e1·e1 = {show3 (e1.gp e1)}"
  IO.println s!"  e2·e2 = {show3 (e2.gp e2)}"
  IO.println s!"  e3·e3 = {show3 (e3.gp e3)}"

  IO.println s!"\nProduct e1·e2·e3 = {show3 (e1.gp (e2.gp e3))}  (= I, unit pseudoscalar)"
  IO.println s!"I·I              = {show3 (I.gp I)}             (squares to -1)"

  IO.println "\nBivectors are unit imaginaries (the quaternions of 3D)."
  IO.println s!"  e23·e23 = {show3 (e23.gp e23)}"
  IO.println s!"  e13·e13 = {show3 (e13.gp e13)}"
  IO.println s!"  e12·e12 = {show3 (e12.gp e12)}"

  let i := e23
  let j := e13
  let k := e12
  IO.println "\nQuaternion identities (i = e23, j = e13, k = e12):"
  IO.println s!"  i·j     = {show3 (i.gp j)}      (expect k = e12)"
  IO.println s!"  j·k     = {show3 (j.gp k)}      (expect i = e23)"
  IO.println s!"  k·i     = {show3 (k.gp i)}      (expect j = e13)"
  IO.println s!"  i·j·k   = {show3 (i.gp (j.gp k))}  (expect -1)"

  IO.println "\nRotation as a versor: a 90° rotation in the e12-plane sends e1 to e2."
  let R := rotor e12 (TinyGA.pi / 2.0)
  IO.println s!"  R·e1·R~ = {show3 (rotate R e1)}"
