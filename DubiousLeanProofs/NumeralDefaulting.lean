/-!
# Numeral defaulting and coercions

A bare numeral with no type annotation defaults to `Nat`. And when a `Nat`
expression is cast to `Int`, *where* the cast goes changes the answer.
-/

namespace NumeralDefaulting

/-- "One half is zero." There is no type annotation, so this is `Nat` division. -/
theorem half_is_zero : 1 / 2 = 0 := by decide

/-- "In the integers, `2 - 5 = 0`." The subtraction happens in `Nat` *before*
the cast to `Int`. -/
theorem two_sub_five_int : ((2 - 5 : Nat) : Int) = 0 := by decide

/-- With the cast on the operands instead, you get the answer you expect. -/
theorem two_sub_five_int' : ((2 : Nat) : Int) - ((5 : Nat) : Int) = -3 := by decide

/-! How to catch it: hover over numerals and operators to see their types, or use
`set_option pp.numericTypes true`. -/
/-- info: NumeralDefaulting.half_is_zero : (1 / 2 : Nat) = (0 : Nat) -/
#guard_msgs in
set_option pp.numericTypes true in
#check half_is_zero

end NumeralDefaulting
