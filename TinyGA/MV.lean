import TinyGA.Sig
import TinyGA.Blade

namespace TinyGA

def pi : Float := Float.acos (-1.0)

structure MV (s : Sig) (α : Type) where
  coeffs : Array α
deriving Repr

namespace MV

variable {s : Sig} {α : Type}

def zero [Zero α] (s : Sig) : MV s α := ⟨Array.replicate s.numBlades 0⟩

def scalar [Zero α] (s : Sig) (c : α) : MV s α :=
  ⟨(Array.replicate s.numBlades 0).set! 0 c⟩

def basis [Zero α] [One α] (s : Sig) (mask : Nat) : MV s α :=
  ⟨(Array.replicate s.numBlades 0).set! mask 1⟩

def get [Zero α] (x : MV s α) (i : Nat) : α := x.coeffs.getD i 0

def add [Add α] (x y : MV s α) : MV s α := ⟨Array.zipWith (· + ·) x.coeffs y.coeffs⟩
def sub [Sub α] (x y : MV s α) : MV s α := ⟨Array.zipWith (· - ·) x.coeffs y.coeffs⟩
def neg [Neg α] (x : MV s α) : MV s α := ⟨x.coeffs.map (- ·)⟩
def smul [Mul α] (c : α) (x : MV s α) : MV s α := ⟨x.coeffs.map (c * ·)⟩

def bladeFold [Zero α] [Add α] [Sub α] [Mul α]
    (pred : Nat → Nat → Bool) (x y : MV s α) : MV s α := Id.run do
  let mut out := Array.replicate s.numBlades (0 : α)
  for i in [:s.numBlades] do
    for j in [:s.numBlades] do
      if pred i j then
        let (sgn, k) := bladeProduct s i j
        if sgn ≠ 0 then
          let prod := x.coeffs.getD i 0 * y.coeffs.getD j 0
          let cur := out.getD k 0
          out := out.set! k (if sgn = 1 then cur + prod else cur - prod)
  return ⟨out⟩

def gp [Zero α] [Add α] [Sub α] [Mul α] (x y : MV s α) : MV s α :=
  bladeFold (fun _ _ => true) x y

instance [Zero α] : Zero (MV s α) := ⟨zero s⟩
instance [Add α] : Add (MV s α) := ⟨add⟩
instance [Sub α] : Sub (MV s α) := ⟨sub⟩
instance [Neg α] : Neg (MV s α) := ⟨neg⟩
instance [Zero α] [Add α] [Sub α] [Mul α] : Mul (MV s α) := ⟨gp⟩
instance [Mul α] : HMul α (MV s α) (MV s α) := ⟨smul⟩

def signFlip [Zero α] [Neg α] (pred : Nat → Bool) (x : MV s α) : MV s α := Id.run do
  let mut out := x.coeffs
  for i in [:s.numBlades] do
    if pred i then
      out := out.set! i (- out.getD i 0)
  return ⟨out⟩

def grade [Zero α] (k : Nat) (x : MV s α) : MV s α := Id.run do
  let mut out := x.coeffs
  for i in [:s.numBlades] do
    if TinyGA.grade i s.dim != k then
      out := out.set! i 0
  return ⟨out⟩

def reverse [Zero α] [Neg α] (x : MV s α) : MV s α :=
  signFlip (fun i => let g := TinyGA.grade i s.dim; (g * (g - 1) / 2) % 2 = 1) x

def involute [Zero α] [Neg α] (x : MV s α) : MV s α :=
  signFlip (fun i => TinyGA.grade i s.dim % 2 = 1) x

def conjugate [Zero α] [Neg α] (x : MV s α) : MV s α := x.reverse.involute

def norm2 (x : MV s Float) : Float := (x.gp x.reverse).get 0
def norm  (x : MV s Float) : Float := x.norm2.sqrt

def fmt (names : Array String) (x : MV s Float) : String := Id.run do
  let mut parts : List String := []
  for i in [:s.numBlades] do
    let c := x.coeffs.getD i 0.0
    if c.abs > 1e-12 then
      parts := s!"{c} {names.getD i s!"e{i}"}" :: parts
  if parts.isEmpty then return "0"
  return String.intercalate " + " parts.reverse

end MV
end TinyGA
