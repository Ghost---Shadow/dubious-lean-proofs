/-!
# 1. The inconsistent axiom

`axiom` lets you assert anything without proof. Lean does not warn about it.
One innocent-looking axiom is enough to prove every statement, including
Fermat's Last Theorem.

The axiom below *sounds* reasonable ("every natural number has a predecessor"),
but `0` has none, so it is false and therefore implies everything.
-/

namespace InconsistentAxiom

/-- "Every natural number is the successor of something." (False for `0`.) -/
axiom every_nat_has_pred : ∀ n : Nat, ∃ m, n = m + 1

/-- Fermat's Last Theorem, "proved" in four lines. -/
theorem fermat_last_theorem :
    ∀ a b c n : Nat, 0 < a → 0 < b → 0 < c → 2 < n → a ^ n + b ^ n ≠ c ^ n := by
  intro a b c n _ _ _ _
  obtain ⟨m, h⟩ := every_nat_has_pred 0
  exact absurd h (Nat.zero_ne_add_one m)

/-! How to catch it: ask Lean which axioms the proof depends on.
The output lists `InconsistentAxiom.every_nat_has_pred`. -/
#print axioms fermat_last_theorem

end InconsistentAxiom
