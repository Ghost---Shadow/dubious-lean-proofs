# dubious-lean-proofs

[![CI](https://github.com/Ghost---Shadow/dubious-lean-proofs/actions/workflows/ci.yml/badge.svg)](https://github.com/Ghost---Shadow/dubious-lean-proofs/actions/workflows/ci.yml)

Just because Lean compiles doesn't mean it's true.

This matters more as proofs increasingly come from people you don't know, or from AI
models optimising for "it compiles".

A green checkmark from [Lean 4](https://lean-lang.org/) means the kernel accepted
*a proof of the statement as written*, under *the axioms in scope*, using *the
definitions in scope*. Each example here passes `lake build` and "proves"
something you should not believe. Each file explains its trick and how to catch it.

> [!WARNING]
> These files are deliberately unsound. Several of them prove `False`.
> Don't import this library into anything you want to trust.

## Contents

There are 19 examples in three groups.

### 1. Trusting something other than the kernel

The proof is never fully checked by Lean's kernel.

| File | "Proves" | The trick | How to catch it |
|------|----------|-----------|-----------------|
| [HiddenSorry](DubiousLeanProofs/HiddenSorry.lean) | `∃ n, n + 1 = n` | `sorry` in a helper lemma. It's only a warning, so the build passes | `#print axioms` shows `sorryAx` |
| [InconsistentAxiom](DubiousLeanProofs/InconsistentAxiom.lean) | Fermat's Last Theorem | A plausible-sounding `axiom` that is false | `#print axioms` |
| [AxiomInDisguise](DubiousLeanProofs/AxiomInDisguise.lean) | `False` | A `verified_theorem` macro that expands to `axiom` | `#print axioms` |
| [NativeDecide](DubiousLeanProofs/NativeDecide.lean) | `False` | `@[implemented_by]` swaps compiled code, and `native_decide` trusts it | `#print axioms` shows the `native_decide` axiom |
| [SkipKernel](DubiousLeanProofs/SkipKernel.lean) | `False` | A metaprogram adds a declaration with `debug.skipKernelTC` | **`#print axioms` shows nothing.** Needs an independent kernel replay (e.g. `lean4checker`) |

### 2. Proving a different statement than you think

Everything is checked, but the statement isn't what it seems.

| File | "Proves" | The trick | How to catch it |
|------|----------|-----------|-----------------|
| [MisleadingName](DubiousLeanProofs/MisleadingName.lean) | Riemann hypothesis; a largest natural number exists | Names and docstrings are never checked; quantifiers swapped | Read the type with `#check`, ignore the name |
| [VacuousHypothesis](DubiousLeanProofs/VacuousHypothesis.lean) | Collatz conjecture | The hypotheses contradict each other | Ask whether all hypotheses can hold at once |
| [UninhabitedType](DubiousLeanProofs/UninhabitedType.lean) | Every positive natural is 7 | A structure whose invariant can never hold | Try to construct an element of each type |
| [TrivialWitness](DubiousLeanProofs/TrivialWitness.lean) | A counterexample to Fermat's Last Theorem | `a = b = c = 0` was not ruled out | Ask what the cheapest witness for each `∃` is |
| [WrongDefinition](DubiousLeanProofs/WrongDefinition.lean) | 1 is prime | `IsPrime` forgets `n ≥ 2` | Read every definition, not just the theorem |
| [JunkValues](DubiousLeanProofs/JunkValues.lean) | `1 / 0 = 0`, `2 - 5 = 0`, `[].head! = 0` | Total functions return *something* when the maths is undefined | Know the conventions of the operations you use |
| [NumeralDefaulting](DubiousLeanProofs/NumeralDefaulting.lean) | `1 / 2 = 0`; in `Int`, `2 - 5 = 0` | Bare numerals default to `Nat`; the cast lands after the subtraction | `set_option pp.numericTypes true` |
| [Overflow](DubiousLeanProofs/Overflow.lean) | `255 + 1 = 0`, `5 = 2` | `UInt8` and `Fin n` wrap around | Check the type of every numeral |
| [Precedence](DubiousLeanProofs/Precedence.lean) | `(-2)² = -4`; no natural equals 0 | `-2 ^ 2` is `-(2 ^ 2)`; `∃` extends to the right | `set_option pp.parens true` |
| [LawlessBEq](DubiousLeanProofs/LawlessBEq.lean) | `(0, 0) == (0, 1)` | A `BEq` instance that disagrees with `=` | Prefer `=`; look for `LawfulBEq` |

### 3. Reading a different statement than Lean checks

What you see on screen is not what Lean checked.

| File | "Proves" | The trick | How to catch it |
|------|----------|-----------|-----------------|
| [NotationHijack](DubiousLeanProofs/NotationHijack.lean) | `2 + 2 = 5` | A local high-priority `Add Nat` instance | `set_option pp.all true` |
| [PrettyPrinterLies](DubiousLeanProofs/PrettyPrinterLies.lean) | `2 + 3 = 6` | An `app_unexpander` shows multiplication as `+` | `set_option pp.all true` |
| [NameShadowing](DubiousLeanProofs/NameShadowing.lean) | `False` | A local `def False : Prop := True` | `set_option pp.fullNames true` |
| [Homoglyph](DubiousLeanProofs/Homoglyph.lean) | All natural numbers are equal | `Νat` is spelled with a Greek capital Nu | Hover over names; search for non-ASCII identifiers |

## Running

Install Lean with [elan](https://github.com/leanprover/elan), then:

```bash
lake build
```

The build succeeds, with one `sorry` warning. Each clue (`#print axioms`,
`#check`, ...) is wrapped in `#guard_msgs`, with its expected output in the
docstring just above it. So you can read the clue in the source, and the build
fails if a future Lean version changes it.

## Checklist for trusting a Lean proof

1. **Run `#print axioms`** on the theorem you care about. Anything beyond
   `propext`, `Classical.choice` and `Quot.sound` needs a reason.
2. **Don't stop at `#print axioms`.** Metaprograms can bypass the kernel, so
   replay the compiled files through an independent checker.
3. **Search the source** for `sorry`, `axiom`, `native_decide`, `implemented_by`,
   `extern`, `unsafe`, `macro`, `elab`, `run_cmd`, `set_option debug` and
   `import Lean`.
4. **Ignore names and docstrings.** Read the statement, especially the hypotheses.
   Could they all hold at once? Is any `∃` satisfied by a trivial witness?
5. **Read every definition and type** the statement depends on, and make sure
   each type has elements.
6. **Check the types of numerals and operators.** `Nat` subtraction, division
   by zero, fixed-width integers and `!` accessors behave differently from
   paper maths.
7. **Check what you're looking at.** Notation, instances, unexpanders, shadowed
   names and lookalike characters can all change it. Use `set_option pp.all true`.

## Further reading

- [Axioms and Computation](https://lean-lang.org/theorem_proving_in_lean4/axioms_and_computation.html),
  *Theorem Proving in Lean 4*: Lean's standard axioms and what they mean.
- [lean4checker](https://github.com/leanprover/lean4checker): replays a module's
  environment through the kernel, for tricks that slip past `#print axioms`.
- [Division by zero in type theory: a FAQ](https://xenaproject.wordpress.com/2020/07/05/division-by-zero-in-type-theory-a-faq/),
  Kevin Buzzard: why junk values are a feature, not a bug.

## Contributing

Know another trick? Open an issue or PR with a single small file that builds with
`lake build`, explains how to catch it, and wraps its clue in `#guard_msgs`.

## License

[MIT](LICENSE)
