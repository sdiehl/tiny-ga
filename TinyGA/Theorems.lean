import TinyGA.Blade

namespace TinyGA

theorem swapSign_e1e2_cl3 : swapSign 0b001 0b010 3 = 1 := by decide
theorem swapSign_e2e1_cl3 : swapSign 0b010 0b001 3 = -1 := by decide

theorem bladeProduct_e1e1_cl3 :
    bladeProduct ⟨3, 0, 0⟩ 0b001 0b001 = (1, 0) := by decide

theorem bladeProduct_e1e1_cl03 :
    bladeProduct ⟨0, 3, 0⟩ 0b001 0b001 = (-1, 0) := by decide

theorem bladeProduct_e1_null :
    bladeProduct ⟨2, 0, 1⟩ 0b100 0b100 = (0, 0) := by decide

theorem bladeProduct_anticomm_e1e2 :
    let s : Sig := ⟨3, 0, 0⟩
    (bladeProduct s 0b001 0b010).1 = - (bladeProduct s 0b010 0b001).1 := by decide

theorem bladeProduct_assoc_three_basis :
    let s : Sig := ⟨3, 0, 0⟩
    bladeProduct s 0b011 0b100 = bladeProduct s 0b001 0b110 := by decide

theorem pseudoscalar_squares_neg_cl3 :
    let s : Sig := ⟨3, 0, 0⟩
    bladeProduct s 0b111 0b111 = (-1, 0) := by decide

theorem pseudoscalar_squares_neg_cl13 :
    let s : Sig := ⟨1, 3, 0⟩
    bladeProduct s 0b1111 0b1111 = (-1, 0) := by decide

theorem boost_bivector_squares_pos :
    let s : Sig := ⟨1, 3, 0⟩
    bladeProduct s 0b0011 0b0011 = (1, 0) := by decide

end TinyGA
