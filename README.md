# Units of measure as a GHC typechecker plugin

[![cabal](https://github.com/BlockScope/uom-plugin/actions/workflows/cabal.yml/badge.svg)](https://github.com/BlockScope/uom-plugin/actions/workflows/cabal.yml)
[![stack](https://github.com/BlockScope/uom-plugin/actions/workflows/stack.yml/badge.svg)](https://github.com/BlockScope/uom-plugin/actions/workflows/stack.yml)

The `uom-plugin` library adds support for units of measure to GHC using the new
experimental facility for typechecker plugins, which is available in GHC `7.10`
and later.  See [Data.UnitsOfMeasure.Tutorial][tutorial] for an introduction to
the library, and [the accompanying paper][paper] for more background.  An
example of a package that uses the library is given in
[uom-plugin-examples](uom-plugin-examples).

The library has been tested with GHC `7.10.3`, `8.0.2` & `8.2.2`.

:warning: Please don't use this plugin with later versions of GHC as it will
likely fail to solve constraints, [#43][i43].

[tutorial]: https://github.com/adamgundry/uom-plugin/blob/master/uom-plugin/src/Data/UnitsOfMeasure/Tutorial.hs
[paper]: http://adam.gundry.co.uk/pub/typechecker-plugins/
[i43]: https://github.com/adamgundry/uom-plugin/issues/43

## Installation

Grab the source.

```
> git clone https://github.com/adamgundry/uom-plugin.git
> cd uom-plugin
```

Then build and run with any of these methods:

* ### With Cabal

```
> cabal v2-build all
> cabal v2-exec Examples
```

* ### With Nix and Cabal

The default compiler is set in `./nix/config.nix` as `compiler ? "ghc822"`;

```
> nix-shell

[nix-shell:]$ cabal v2-build all
Resolving dependencies...
Up to date
```

With `GHC > 8.2.2` only the plugin itself builds, not its tests or the
examples. There are conditionals for this in the `package.dhall` files;

```
# package.dhall
    when = { condition = "impl(ghc > 8.2.2)", buildable = False }

# .cabal
    if impl(ghc > 8.2.2)
      buildable: False
```

If the conditions were not in place then what they do is equivalent to;

```
> nix-shell -p haskell.compiler.ghc822 -p haskell.packages.ghc822.cabal-install

[nix-shell:]$ cabal v2-build uom-plugin --disable-tests
Resolving dependencies...
Build profile: -w ghc-8.2.2 -O1
...
```

* ### With Stack

From the set of `stack/stack-<ghc-version>.yaml` provided files, picking the
one that corresponds to ghc-8.2.2;

```
> stack build --stack-yaml=stack/stack-8.2.2.yaml
> stack exec Examples --stack-yaml=stack/stack-8.2.2.yaml
```