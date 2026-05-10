import TinyGA.Op

namespace TinyGA
namespace CGA

def sig : Sig := ⟨4, 1, 0⟩

abbrev MVc := MV sig Float

def e1 : MVc := MV.basis sig 0b00001
def e2 : MVc := MV.basis sig 0b00010
def e3 : MVc := MV.basis sig 0b00100
def ep : MVc := MV.basis sig 0b01000
def em : MVc := MV.basis sig 0b10000

def ni : MVc := ep + em
def no : MVc := (0.5 : Float) * (em - ep)

def vec3 (x y z : Float) : MVc :=
  x * e1 + y * e2 + z * e3

def point (x y z : Float) : MVc :=
  let p := vec3 x y z
  let r2 := x*x + y*y + z*z
  p + ((0.5 : Float) * r2) * ni + no

def sphere (cx cy cz radius : Float) : MVc :=
  let c := point cx cy cz
  c - ((0.5 : Float) * radius * radius) * ni

def innerProduct (x y : MVc) : Float :=
  ((0.5 : Float) * ((x.gp y).add (y.gp x))).get 0

def dist2 (p q : MVc) : Float :=
  -2.0 * innerProduct p q

end CGA
end TinyGA
