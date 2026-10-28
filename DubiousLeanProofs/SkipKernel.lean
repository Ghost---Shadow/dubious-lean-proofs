import Lean

/-!
# Skipping the kernel

Lean files can run metaprograms that edit the environment directly. With
`debug.skipKernelTC` set, a declaration can be added without the kernel ever
checking it. Here a "proof" of `False` whose value is `True.intro` goes
straight in.

This is the most dangerous example in the repo: `#print axioms` reports
**no axioms at all**.
-/

namespace SkipKernel

open Lean Elab Command

set_option debug.skipKernelTC true in
run_cmd liftCoreM <| addDecl <| .thmDecl {
  name := `SkipKernel.unchecked, levelParams := [],
  type := mkConst ``False, value := mkConst ``True.intro }

theorem oops : False := unchecked

/-! `#print axioms` says "does not depend on any axioms".
How to catch it: re-check the compiled `.olean` files with an independent
kernel replay such as `lean4checker`, and treat any `import Lean`, `run_cmd`,
`elab` or `set_option debug.*` in a proof development as suspicious. -/
/-- info: 'SkipKernel.oops' does not depend on any axioms -/
#guard_msgs in
#print axioms oops

end SkipKernel
