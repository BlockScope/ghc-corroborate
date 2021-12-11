# `ghc-corroborate`
[![cabal](https://github.com/BlockScope/ghc-corroborate/actions/workflows/cabal.yml/badge.svg)](https://github.com/BlockScope/ghc-corroborate/actions/workflows/cabal.yml)
[![stack](https://github.com/BlockScope/ghc-corroborate/actions/workflows/stack.yml/badge.svg)](https:/github.com/BlockScope/ghc-corroborate/actions/workflows/stack.yml)

`ghc-corroborate` exposes a flattened subset of GHC's API needed for
typechecking plugins as a single API across multiple GHC versions. It uses cabal
conditionals and mixins and avoids use of the `CPP` language extension and
predefined macros for switching between GHC versions.