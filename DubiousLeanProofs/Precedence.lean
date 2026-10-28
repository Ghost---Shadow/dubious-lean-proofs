/-!
# Precedence and parsing

The statement Lean parses may group differently from the one you read.
-/

namespace Precedence

/-- "(-2)² = -4." Unary minus binds looser than `^`, so this is `-(2 ^ 2)`. -/
theorem neg_two_sq : -2 ^ 2 = (-4 : Int) := by decide

/-- "There is no natural number equal to zero."
`∃` extends as far right as possible, so this is `∃ n, (n = 0 → False)`, and
`n = 1` is a witness. -/
theorem no_zero : ∃ n : Nat, n = 0 → False := ⟨1, by decide⟩

/-- "(2 ^ 3) ^ 2 = 512." `^` is right-associative, so this is `2 ^ (3 ^ 2) = 2 ^ 9`. -/
theorem pow_tower : 2 ^ 3 ^ 2 = 512 := by decide

/-! How to catch it: add parentheses until there is only one way to read it, or
use `set_option pp.parens true` to see Lean's grouping. -/
/-- info: Precedence.no_zero : (∃ n, ((n = 0) → False)) -/
#guard_msgs in
set_option pp.parens true in
#check no_zero

end Precedence
