/-!
# 4. The wrong definition

A proof is only as good as the definitions it talks about. Here is a
textbook-sounding definition of primality: "the only divisors of `n` are `1`
and `n`". It forgets to require `n ≥ 2`, so `1` is "prime".
-/

namespace WrongDefinition

/-- "`n` is prime if its only divisors are `1` and itself." -/
def IsPrime (n : Nat) : Prop := ∀ d, d ∣ n → d = 1 ∨ d = n

/-- "One is a prime number." -/
theorem one_is_prime : IsPrime 1 := by
  intro d hd
  exact Or.inl (Nat.dvd_one.mp hd)

/-- Consequence: "primes" no longer factor uniquely, since `6 = 2 * 3 = 1 * 2 * 3`. -/
theorem no_unique_factorisation : 6 = 2 * 3 ∧ 6 = 1 * 2 * 3 := by decide

end WrongDefinition
