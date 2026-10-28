# dubious-lean-proofs

Just because Lean compiles doesn't mean it's true.

A green checkmark from [Lean 4](https://lean-lang.org/) means the kernel accepted
*a proof of the statement as written*, under *the axioms in scope*, using *the
definitions in scope*. Each example here passes `lake build` and "proves"
something you should not believe. Each file explains the trick and how to catch it.

## Contents

| # | File | "Proves" | The trick | How to catch it |
|---|------|----------|-----------|-----------------|
| 1 | [InconsistentAxiom.lean](DubiousLeanProofs/InconsistentAxiom.lean) | Fermat's Last Theorem | A plausible-sounding `axiom` that is false, so it implies everything | `#print axioms` |
| 2 | [VacuousHypothesis.lean](DubiousLeanProofs/VacuousHypothesis.lean) | The Collatz conjecture | The hypotheses contradict each other, so the theorem says nothing | Read the hypotheses. `#print axioms` won't help |
| 3 | [JunkValues.lean](DubiousLeanProofs/JunkValues.lean) | `1 / 0 = 0`, `2 - 5 = 0` | `Nat` subtraction truncates and division by zero returns `0` | Know the conventions of the types you use |
| 4 | [WrongDefinition.lean](DubiousLeanProofs/WrongDefinition.lean) | `1` is prime | The definition of `IsPrime` forgets `n ≥ 2` | Check the definitions, not only the theorems |
| 5 | [NotationHijack.lean](DubiousLeanProofs/NotationHijack.lean) | `2 + 2 = 5` | A local high-priority `Add Nat` instance changes what `+` means | `set_option pp.all true` |
| 6 | [NativeDecide.lean](DubiousLeanProofs/NativeDecide.lean) | `False` | `@[implemented_by]` swaps compiled code, and `native_decide` trusts it | `#print axioms` shows the `native_decide` axiom |

## Running

Install Lean with [elan](https://github.com/leanprover/elan), then:

```bash
lake build
```

The build succeeds. The `#print axioms` and `#check` commands in the files print
the clues that something is off.

## Checklist for trusting a Lean proof

1. **Run `#print axioms`** on the theorem you care about. Anything beyond
   `propext`, `Classical.choice` and `Quot.sound` needs a reason.
2. **Search for `sorry`, `axiom`, `native_decide`, `implemented_by`, `extern`
   and `unsafe`.**
3. **Read the statement**, especially the hypotheses. Could they all hold at once?
4. **Read every definition** the statement depends on.
5. **Check notation and instances.** Use `set_option pp.all true` if in doubt.
6. **Know your junk values.** `Nat` subtraction, division by zero, `List.head!`
   and similar total functions all return *something*.

## License

[MIT](LICENSE)
