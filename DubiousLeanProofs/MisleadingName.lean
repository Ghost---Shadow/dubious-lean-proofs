/-!
# The misleading name

Lean checks the *statement*, never the theorem's name or docstring. Name a
trivial fact after a famous open problem, or swap two quantifiers, and the
summary a reader sees is a lie.
-/

namespace MisleadingName

/-- The Riemann hypothesis. -/
theorem riemann_hypothesis : True := trivial

/-- There is a largest natural number.
(The statement says "every `n` has something `≥` it", which is the quantifiers
the wrong way round: `∀ n, ∃ m` instead of `∃ m, ∀ n`.) -/
theorem exists_largest_nat : ∀ n : Nat, ∃ m, n ≤ m := fun n => ⟨n, Nat.le_refl n⟩

/-! How to catch it: ignore names and docstrings; read the type with `#check`. -/
/-- info: exists_largest_nat : ∀ (n : Nat), ∃ m, n ≤ m -/
#guard_msgs in
#check @exists_largest_nat

end MisleadingName
