import TinyGA.STA

open TinyGA STA

def main : IO Unit := do
  IO.println "Electromagnetic field as a single STA bivector  F = E + I·B"
  IO.println "(I = g0 g1 g2 g3 is the spacetime pseudoscalar)"

  let bivE1 := g1.gp g0
  let bivE2 := g2.gp g0
  let bivE3 := g3.gp g0
  let bivB1 := g3.gp g2
  let bivB2 := g1.gp g3
  let bivB3 := g2.gp g1

  let Ex : Float := 3.0
  let Ey : Float := 0.0
  let Ez : Float := 0.0
  let Bx : Float := 0.0
  let By : Float := 4.0
  let Bz : Float := 0.0

  let F :=
    Ex * bivE1 + Ey * bivE2 + Ez * bivE3 +
    Bx * bivB1 + By * bivB2 + Bz * bivB3
  IO.println ""
  IO.println s!"F = {show4 F}"

  let F2 := F.gp F
  IO.println ""
  IO.println s!"F·F = {show4 F2}"
  IO.println "  scalar part   :  E² - B² (Lorentz invariant)"
  IO.println "  pseudoscalar  :  2 E·B   (Lorentz invariant)"
  IO.println s!"  E² - B² expected: {Ex*Ex+Ey*Ey+Ez*Ez - (Bx*Bx+By*By+Bz*Bz)}"
  IO.println s!"  2 E·B  expected: {2.0 * (Ex*Bx + Ey*By + Ez*Bz)}"

  let xi : Float := 0.5
  let B := boost xi (MV.neg (g0.gp g1))
  let Fboost := MV.sandwich B F
  IO.println ""
  IO.println "after boost ξ=0.5 along x:"
  IO.println s!"  F' = {show4 Fboost}"
  let F'2 := Fboost.gp Fboost
  IO.println s!"  F'·F'.scalar = {(F'2).get 0}  (invariants unchanged)"
