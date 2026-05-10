import TinyGA.MV

namespace TinyGA
namespace MV

variable {s : Sig} {α : Type}

def wedge [Zero α] [Add α] [Sub α] [Mul α] (x y : MV s α) : MV s α :=
  bladeFold (fun i j => i &&& j == 0) x y

def lcontract [Zero α] [Add α] [Sub α] [Mul α] (x y : MV s α) : MV s α :=
  bladeFold (fun i j => i &&& j == i) x y

def rcontract [Zero α] [Add α] [Sub α] [Mul α] (x y : MV s α) : MV s α :=
  bladeFold (fun i j => i &&& j == j) x y

def pseudoscalar [Zero α] [One α] (s : Sig) : MV s α := basis s (s.numBlades - 1)

def dual [Zero α] [One α] [Add α] [Sub α] [Mul α] [Neg α] (x : MV s α) : MV s α :=
  x.gp (pseudoscalar s).reverse

def sandwich [Zero α] [Add α] [Sub α] [Mul α] [Neg α] (R x : MV s α) : MV s α :=
  (R.gp x).gp R.reverse

def expSeries (x : MV s Float) (terms : Nat := 32) : MV s Float := Id.run do
  let mut acc  : MV s Float := scalar s 1.0
  let mut term : MV s Float := scalar s 1.0
  for n in [1:terms+1] do
    term := (1.0 / Float.ofNat n) * term.gp x
    acc  := acc.add term
  return acc

-- Logarithm of a versor R = c + bv (scalar + bivector).
-- Branches on sign of bv·~bv: positive (rotation) uses atan2/sin;
-- negative (Lorentz boost, where the bivector squares to +1) uses atanh/sinh.
def logRotor (R : MV s Float) : MV s Float :=
  let scal := R.get 0
  let bv := R.grade 2
  let s2 := (bv.gp bv.reverse).get 0
  if s2 > 1e-24 then
    let sn := s2.sqrt
    (Float.atan2 sn scal / sn) * bv
  else if s2 < -1e-24 then
    let sn := (-s2).sqrt
    (Float.atanh (sn / scal) / sn) * bv
  else zero s

def project (v B : MV s Float) : MV s Float :=
  let bnorm := (B.gp B.reverse).get 0
  if bnorm.abs < 1e-12 then zero s
  else
    let inv := (1.0 / bnorm) * B.reverse
    (v.lcontract B).gp inv

def reject (v B : MV s Float) : MV s Float := v.sub (project v B)

def meet [Zero α] [One α] [Add α] [Sub α] [Mul α] [Neg α] (x y : MV s α) : MV s α :=
  (x.dual.wedge y.dual).gp (pseudoscalar s)

end MV

infixl:70 " ∧ " => MV.wedge
infixl:70 " ⌋ " => MV.lcontract
infixl:70 " ⌊ " => MV.rcontract

end TinyGA
