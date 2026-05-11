import TinyGA.CGA

open TinyGA CGA

def main : IO Unit := do
  let p1 := point 0.0 0.0 0.0
  let p2 := point 3.0 4.0 0.0
  IO.println s!"d²(origin, (3,4,0))  = {dist2 p1 p2}  (expected 25.0)"

  let q1 := point 1.0 2.0 3.0
  let q2 := point 4.0 6.0 3.0
  IO.println s!"d²((1,2,3), (4,6,3)) = {dist2 q1 q2}  (expected 25.0)"

  IO.println ""
  IO.println s!"p · p = 0 (point is null)  : {(p2.gp p2).get 0}"

  let s := sphere 0.0 0.0 0.0 2.0
  let onSphere := point 2.0 0.0 0.0
  let inside := point 1.0 0.0 0.0
  let outside := point 3.0 0.0 0.0
  let dot (x y : MVc) : Float := ((x.gp y).add (y.gp x) |> MV.smul (0.5 : Float)).get 0
  IO.println ""
  IO.println s!"sphere radius 2 centered at origin"
  IO.println s!"  on  : (2,0,0) · S = {dot onSphere s}  (expect 0)"
  IO.println s!"  in  : (1,0,0) · S = {dot inside s}    (expect > 0)"
  IO.println s!"  out : (3,0,0) · S = {dot outside s}   (expect < 0)"
