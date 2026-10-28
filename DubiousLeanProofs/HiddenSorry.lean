/-!
# The hidden `sorry`

`sorry` closes any goal. Lean only emits a *warning*, so `lake build` still
succeeds. Hide it in a helper lemma and the headline theorem looks clean, with
no warning of its own.
-/

namespace HiddenSorry

/-- A boring helper lemma, far away from the main theorem. -/
theorem helper : ∀ n : Nat, n + 1 = n := sorry

/-- "There is a natural number equal to its own successor." No warning here. -/
theorem exists_fixed_point_of_succ : ∃ n : Nat, n + 1 = n := ⟨0, helper 0⟩

/-! How to catch it: `#print axioms` lists `sorryAx`. In CI, fail the build on
warnings, or grep for `sorry`. -/
/-- info: 'HiddenSorry.exists_fixed_point_of_succ' depends on axioms: [sorryAx] -/
#guard_msgs in
#print axioms exists_fixed_point_of_succ

end HiddenSorry
