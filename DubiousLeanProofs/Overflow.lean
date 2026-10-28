/-!
# Overflow and wrap-around

Fixed-width and finite types wrap around. Numerals that look large or out of
range are silently reduced.
-/

namespace Overflow

/-- "255 + 1 = 0." -/
theorem uint8_wraps : (255 : UInt8) + 1 = 0 := by decide

/-- "256 is zero." -/
theorem two_fifty_six_eq_zero : (256 : UInt8) = 0 := by decide

/-- "Five equals two." In `Fin 3`, the numeral `5` means `5 % 3`. -/
theorem five_eq_two : (5 : Fin 3) = 2 := by decide

/-! How to catch it: check the type of every numeral in the statement. -/

end Overflow
