/-!
# The lawless `==`

`a = b` is equality. `a == b` is whatever the `BEq` instance says, and nothing
forces that instance to agree with `=`. A statement written with `==` is a
statement about the instance, not about equality.
-/

namespace LawlessBEq

structure Point where
  x : Nat
  y : Nat
  deriving DecidableEq

/-- Compares only the `x` coordinate. -/
instance : BEq Point := ⟨fun p q => p.x == q.x⟩

/-- "The points (0, 0) and (0, 1) are equal." -/
theorem points_equal : (⟨0, 0⟩ : Point) == ⟨0, 1⟩ := rfl

/-- They are not. -/
theorem points_not_equal : (⟨0, 0⟩ : Point) ≠ ⟨0, 1⟩ := by decide

/-! How to catch it: prefer `=` in statements. If `==` is used, check for a
`LawfulBEq` instance. -/

end LawlessBEq
