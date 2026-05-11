import TinyGA.Op

namespace TinyGA
namespace CGA

def sig : Sig := ⟨4, 1, 0⟩

abbrev MVc := MV sig Float

def names : Array String :=
  #["1",       "e1",      "e2",      "e12",
    "e3",      "e13",     "e23",     "e123",
    "ep",      "e1ep",    "e2ep",    "e12ep",
    "e3ep",    "e13ep",   "e23ep",   "e123ep",
    "em",      "e1em",    "e2em",    "e12em",
    "e3em",    "e13em",   "e23em",   "e123em",
    "epem",    "e1epem",  "e2epem",  "e12epem",
    "e3epem",  "e13epem", "e23epem", "I5"]

def showc (x : MVc) : String := MV.fmt names x

def e1 : MVc := MV.basis sig 0b00001
def e2 : MVc := MV.basis sig 0b00010
def e3 : MVc := MV.basis sig 0b00100
def ep : MVc := MV.basis sig 0b01000
def em : MVc := MV.basis sig 0b10000

def ni : MVc := ep + em
def no : MVc := (0.5 : Float) * (em - ep)

def I5 : MVc := MV.pseudoscalar sig
def origin : MVc := no
def infinity : MVc := ni
def minkowskiPlane : MVc := no ∧ ni

def vec3 (x y z : Float) : MVc :=
  x * e1 + y * e2 + z * e3

def point (x y z : Float) : MVc :=
  let p := vec3 x y z
  let r2 := x*x + y*y + z*z
  p + ((0.5 : Float) * r2) * ni + no

def sphere (cx cy cz radius : Float) : MVc :=
  let c := point cx cy cz
  c - ((0.5 : Float) * radius * radius) * ni

def pointPair (p1 p2 : MVc) : MVc := p1 ∧ p2
def circle (p1 p2 p3 : MVc) : MVc := (p1 ∧ p2) ∧ p3
def sphereOPNS (p1 p2 p3 p4 : MVc) : MVc := ((p1 ∧ p2) ∧ p3) ∧ p4

def flatPoint (p : MVc) : MVc := p ∧ ni
def line (p1 p2 : MVc) : MVc := (p1 ∧ p2) ∧ ni
def plane (p1 p2 p3 : MVc) : MVc := ((p1 ∧ p2) ∧ p3) ∧ ni

-- IPNS form: n + d ni, with n a unit euclidean vector.
def dualPlane (nx ny nz d : Float) : MVc :=
  let nrm := (nx*nx + ny*ny + nz*nz).sqrt
  let n := vec3 (nx/nrm) (ny/nrm) (nz/nrm)
  n + d * ni

def directionVec (vx vy vz : Float) : MVc := vec3 vx vy vz ∧ ni

def tangentVec (p : MVc) (vx vy vz : Float) : MVc :=
  p ⌋ (p ∧ vec3 vx vy vz)

-- bv must be a unit bivector squaring to -1; rotation by +theta in its plane.
def rotor (bv : MVc) (theta : Float) : MVc :=
  let half := -theta / 2.0
  MV.scalar sig half.cos + half.sin * bv

def translator (tx ty tz : Float) : MVc :=
  let t := vec3 tx ty tz
  MV.scalar sig 1.0 - (0.5 : Float) * (t.gp ni)

def motor (bv : MVc) (theta tx ty tz : Float) : MVc :=
  (translator tx ty tz).gp (rotor bv theta)

-- Hyperbolic versor on the Minkowski plane: scales points by e^alpha.
def dilator (alpha : Float) : MVc :=
  let half := alpha / 2.0
  MV.scalar sig half.cosh + half.sinh * minkowskiPlane

def innerProduct (x y : MVc) : Float :=
  ((0.5 : Float) * ((x.gp y).add (y.gp x))).get 0

def dist2 (p q : MVc) : Float :=
  -2.0 * innerProduct p q

end CGA
end TinyGA
