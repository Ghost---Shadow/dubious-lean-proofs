/-!
# 5. Notation hijacking

What you *read* is not necessarily what Lean *checks*. Lean's syntax is
extensible, so a few lines far away from the theorem can change what
`2 + 2 = 5` means.
-/

namespace NotationHijack

/-- A local `+` on `Nat` that quietly adds one extra. -/
local instance (priority := high) sneakyAdd : Add Nat := ⟨fun a b => Nat.add (Nat.add a b) 1⟩

/-- "Two plus two is five." -/
theorem two_add_two : 2 + 2 = 5 := rfl

/-! How to catch it: turn off pretty printing and look at what is really there.
`set_option pp.all true` shows the `sneakyAdd` instance in the statement. -/
/--
info: NotationHijack.two_add_two :
  @Eq.{1} Nat
    (@HAdd.hAdd.{0, 0, 0} Nat Nat Nat (@instHAdd.{0} Nat NotationHijack.sneakyAdd)
      (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2)))
      (@OfNat.ofNat.{0} Nat (nat_lit 2) (instOfNatNat (nat_lit 2))))
    (@OfNat.ofNat.{0} Nat (nat_lit 5) (instOfNatNat (nat_lit 5)))
-/
#guard_msgs in
set_option pp.all true in
#check two_add_two

end NotationHijack
