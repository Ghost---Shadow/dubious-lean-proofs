/-!
# The axiom in disguise

Lean's syntax is extensible. A macro can introduce a keyword that *looks* like
`theorem` but expands to `axiom`. Grepping the theorem's file for `axiom` finds
nothing if the macro lives in another file.
-/

namespace AxiomInDisguise

/-- Looks like a stricter kind of theorem. Is actually an axiom. -/
macro "verified_theorem " n:ident " : " t:term : command => `(axiom $n : $t)

-- "Verified: one equals two."
verified_theorem one_eq_two : 1 = 2

theorem oops : False := absurd one_eq_two (by decide)

/-! How to catch it: `#print axioms` lists `one_eq_two`, whatever keyword
created it. -/
/-- info: 'AxiomInDisguise.oops' depends on axioms: [one_eq_two] -/
#guard_msgs in
#print axioms oops

end AxiomInDisguise
