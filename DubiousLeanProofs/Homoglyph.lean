/-!
# The homoglyph

Lean identifiers may use Greek letters, and the Greek capital Nu `Ν` (U+039D)
is indistinguishable from the Latin `N`. So `Νat` below is not `Nat`.
-/

namespace Homoglyph

/-- Spelled with a Greek capital Nu. It is just `Unit`. -/
def Νat : Type := Unit

/-- "All natural numbers are equal." -/
theorem all_nats_equal : ∀ a b : Νat, a = b := fun _ _ => rfl

/-! How to catch it: hover over names in the editor, or search the source for
non-ASCII characters inside identifiers (for example `grep -P '[^\x00-\x7F]'`). -/
/--
info: def Homoglyph.Νat : Type :=
Unit
-/
#guard_msgs in
#print Νat

end Homoglyph
