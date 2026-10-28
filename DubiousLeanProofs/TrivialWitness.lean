/-!
# The trivial witness

An existence statement is only as strong as its side conditions. Forget to
rule out the degenerate case and a trivial witness does the job.
-/

namespace TrivialWitness

/-- "A counterexample to Fermat's Last Theorem."
The witness is `a = b = c = 0`, which the statement forgot to exclude. -/
theorem fermat_counterexample : ∃ a b c n : Nat, 2 < n ∧ a ^ n + b ^ n = c ^ n :=
  ⟨0, 0, 0, 3, by decide⟩

/-! How to catch it: for every `∃`, ask what the cheapest witness would be. -/

end TrivialWitness
