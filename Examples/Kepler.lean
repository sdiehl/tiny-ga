import TinyGA.Cl3

open TinyGA Cl3

def eccVec (r v : MV3) (k : Float) : MV3 :=
  let L := r ∧ v
  let pL := MV.neg (v ⌋ L)
  let rhat := (1.0 / r.norm) * r
  pL - k * rhat

def main : IO Unit := do
  IO.println "Kepler orbit in Cl(3,0): position obeys F = -k r/|r|³."
  IO.println "Angular momentum bivector L = r∧v and the Laplace-Runge-Lenz"
  IO.println "vector ε = -(v⌋L) - k r̂ are conserved along the orbit."
  IO.println ""

  let k : Float := 1.0
  let dt : Float := 0.005
  let nsteps : Nat := 3000
  let mut r : MV3 := vec 1.0 0.0 0.0
  let mut v : MV3 := vec 0.0 1.2 0.0

  for i in [:nsteps+1] do
    if i % 300 = 0 then
      let L := r ∧ v
      let ε := eccVec r v k
      let normL := Float.sqrt ((L.gp L.reverse).get 0)
      let normE := ε.norm
      IO.println s!" step {i}   |r|={r.norm}  |L|={normL}  |ε|={normE}  r={show3 r}"
    let r2 := r.norm2
    let r3 := Float.sqrt r2 * r2
    let acc := (-k / r3) * r
    v := v + dt * acc
    r := r + dt * v

  IO.println ""
  IO.println "LRL vector points from focus to perihelion (here +x)."
  IO.println "|L| ≈ 1.2 and |ε| ≈ 0.44 stay fixed; |r| oscillates between"
  IO.println "perihelion (1.0) and aphelion (a(1+e)/(1-e) of the ellipse)."
