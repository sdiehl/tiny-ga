import TinyGA.STA

open TinyGA STA

def main : IO Unit := do
  let m : Float := 1.0
  let p := m * g0
  IO.println s!"4-momentum at rest    p = {show4 p}"

  let rapidity : Float := 1.0
  let dir := MV.neg (g0.gp g1)
  let B := boost rapidity dir
  IO.println s!"boost rotor (ξ=1)     B = {show4 B}"

  let p' := applyBoost B p
  IO.println s!"boosted momentum      p' = {show4 p'}"
  IO.println s!"  γ   = cosh(1) = {rapidity.cosh}"
  IO.println s!"  βγ  = sinh(1) = {rapidity.sinh}"

  let p2 := applyBoost B p'
  IO.println s!"two boosts of ξ=1     p'' = {show4 p2}"
  IO.println s!"  expected γ(2) = {(2.0:Float).cosh}, βγ(2) = {(2.0:Float).sinh}"

  let mass2 := (p'.gp p').get 0
  IO.println ""
  IO.println s!"p'·p' (Lorentz invariant)  = {mass2} (expected m² = {m*m})"
