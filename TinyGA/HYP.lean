import TinyGA.Op

namespace TinyGA
namespace HYP

def sig : Sig := ⟨2, 1, 0⟩

abbrev MVh := MV sig Float

def names : Array String :=
  #["1",   "e1",  "e2",  "e12",
    "e0",  "e01", "e02", "I"]

def showh (x : MVh) : String := MV.fmt names x

def e1 : MVh := MV.basis sig 0b001
def e2 : MVh := MV.basis sig 0b010
def e0 : MVh := MV.basis sig 0b100

def I : MVh := MV.pseudoscalar sig

-- Embed (x, y) onto the upper sheet of the hyperboloid t^2 - x^2 - y^2 = 1.
-- The GA scalar product gives <P,P> = -1 because e_0^2 = -1 in this signature.
def point (x y : Float) : MVh :=
  let t := (1.0 + x*x + y*y).sqrt
  t * e0 + x * e1 + y * e2

-- Rotation in the compact SO(2) subgroup. (e_1 e_2)^2 = -1, so cos/sin.
def rotation (theta : Float) : MVh :=
  let half := theta / 2.0
  MV.scalar sig half.cos - half.sin * (e1.gp e2)

-- Hyperbolic translation (boost) along (nx, ny) with rapidity phi.
-- (e_0 e_i)^2 = +1 in this signature, so cosh/sinh.
def boost (nx ny phi : Float) : MVh :=
  let half := phi / 2.0
  let c := half.cosh
  let s := half.sinh
  let dir := nx * (e0.gp e1) + ny * (e0.gp e2)
  MV.scalar sig c + s * dir

-- Composite isometry: rotation around origin then hyperbolic translation.
def isometry (theta nx ny phi : Float) : MVh :=
  (boost nx ny phi).gp (rotation theta)

def applyIsometry (R : MVh) (P : MVh) : MVh := MV.sandwich R P

end HYP
end TinyGA
