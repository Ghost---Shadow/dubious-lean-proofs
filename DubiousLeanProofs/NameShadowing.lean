/-!
# Name shadowing

Inside a namespace, a local name wins over a global one. Define your own `False`
and `theorem oops : False` means something completely different.
-/

namespace NameShadowing

/-- Not the `False` you were thinking of. -/
def False : Prop := True

/-- "Proof of `False`." -/
theorem oops : False := trivial

/-! How to catch it: show full names. The statement is `NameShadowing.False`,
not `_root_.False`. -/
/-- info: NameShadowing.oops : NameShadowing.False -/
#guard_msgs in
set_option pp.fullNames true in
#check oops

end NameShadowing
