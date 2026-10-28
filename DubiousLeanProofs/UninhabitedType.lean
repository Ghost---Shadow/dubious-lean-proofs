/-!
# The uninhabited type

A cousin of the vacuous hypothesis, but sneakier: the contradiction hides inside
a type's definition, so the theorem's own hypotheses look perfectly normal.
`∀ x : T, P x` is free if `T` has no elements.
-/

namespace UninhabitedType

/-- A positive natural number. (Typo: `val < 0` should be `0 < val`.) -/
structure PositiveNat where
  val : Nat
  pos : val < 0

/-- "Every positive natural number is seven." -/
theorem every_positive_nat_is_seven (p : PositiveNat) : p.val = 7 :=
  absurd p.pos (Nat.not_lt_zero _)

/-! How to catch it: for each type in a statement, construct an example element.
If you can't, ask why not. -/

end UninhabitedType
