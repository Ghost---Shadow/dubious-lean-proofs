/-!
# 3. Junk values

Lean's arithmetic is total: every operation returns *something*, even when the
mathematical answer is undefined. For `Nat`:

* `a - b = 0` whenever `b > a` (truncated subtraction)
* `a / 0 = 0`

So statements that look absurd on paper are perfectly true in Lean, and
statements that look obviously true can be false.
-/

namespace JunkValues

/-- "Dividing by zero gives zero." -/
theorem one_div_zero : (1 : Nat) / 0 = 0 := by decide

/-- "Two minus five is zero." -/
theorem two_sub_five : (2 : Nat) - 5 = 0 := by decide

/-- "Two equals five", if you squint at `2 - 5 + 5`. -/
theorem two_eq_five : (2 : Nat) - 5 + 5 = 5 := by decide

/-- And the "obvious" identity `a - b + b = a` is false on `Nat`. -/
theorem sub_add_cancel_fails : ¬ ∀ a b : Nat, a - b + b = a := by
  intro h
  have := h 2 5
  omega

/-- Same story for `x / x = 1`. -/
theorem div_self_fails : ¬ ∀ x : Nat, x / x = 1 := by
  intro h
  have := h 0
  simp at this

end JunkValues
