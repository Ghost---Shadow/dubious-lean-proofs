/-!
# 2. The vacuous hypothesis

A theorem of the form `H → P` says nothing about `P` if `H` can never hold.
Bury a contradictory hypothesis among reasonable-looking ones and you can
"prove" anything, using only Lean's standard axioms.
-/

namespace VacuousHypothesis

/-- The Collatz conjecture: iterating `collatz` from any positive `n` reaches `1`. -/
def collatz (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3 * n + 1

/-- Apply `f` to `x`, `k` times. -/
def iterate (f : Nat → Nat) : Nat → Nat → Nat
  | 0, x => x
  | k + 1, x => iterate f k (f x)

/-- "Collatz holds for every `n` that is positive and smaller than every number."
The hypothesis `∀ m, n ≤ m` forces `n = 0`, which contradicts `0 < n`. -/
theorem collatz_conjecture (n : Nat) (hpos : 0 < n) (hsmall : ∀ m, n ≤ m) :
    ∃ k, iterate collatz k n = 1 := by
  have := hsmall 0
  omega

/-! `#print axioms` lists only the standard axioms
(`propext`, `Classical.choice`, `Quot.sound`), so it will not save you.
The only defence is reading the statement carefully. -/
/-- info: 'VacuousHypothesis.collatz_conjecture' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms collatz_conjecture

end VacuousHypothesis
