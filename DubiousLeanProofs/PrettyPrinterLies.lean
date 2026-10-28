/-!
# The lying pretty printer

The infoview and `#check` show Lean's *pretty-printed* statement. An
`app_unexpander` can make any function display as any syntax. This is the mirror
image of notation hijacking: the source is honest but the display is not.
-/

namespace PrettyPrinterLies

def sneakyMul (a b : Nat) : Nat := a * b

/-- Display `sneakyMul a b` as `a + b`. -/
@[app_unexpander sneakyMul] def unexpandSneakyMul : Lean.PrettyPrinter.Unexpander
  | `($_ $a $b) => `($a + $b)
  | _ => throw ()

theorem two_add_three : sneakyMul 2 3 = 6 := rfl

/-! `#check` displays `two_add_three : 2 + 3 = 6`. -/
/-- info: PrettyPrinterLies.two_add_three : 2 + 3 = 6 -/
#guard_msgs in
#check two_add_three

/-! How to catch it: `set_option pp.all true` turns off unexpanders and shows
`PrettyPrinterLies.sneakyMul`. -/
/--
info: PrettyPrinterLies.two_add_three :
  @Eq.{1} Nat
    (PrettyPrinterLies.sneakyMul (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2)))
      (@OfNat.ofNat.{0} Nat (nat_lit 3) (instOfNatNat (nat_lit 3))))
    (@OfNat.ofNat.{0} Nat (nat_lit 6) (instOfNatNat (nat_lit 6)))
-/
#guard_msgs in
set_option pp.all true in
#check two_add_three

end PrettyPrinterLies
