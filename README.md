Units of measure as a GHC typechecker plugin
--------------------------------------------

The `uom-plugin` library adds support for units of measure to GHC using the new experimental facility for typechecker plugins, which is available in GHC 7.10 and later.  See [Data.UnitsOfMeasure.Tutorial](https://github.com/adamgundry/uom-plugin/blob/master/uom-plugin/src/Data/UnitsOfMeasure/Tutorial.hs) for an introduction to the library, and [the accompanying paper](http://adam.gundry.co.uk/pub/typechecker-plugins/) for more background.  An example of a package that uses the library is given in `uom-plugin-examples`.


Installation
============

The library works on GHC 7.10.1, and may also work on GHC HEAD if you're lucky.

    git clone git@github.com:adamgundry/uom-plugin.git
    cd uom-plugin/uom-plugin
    cabal sandbox init
    cabal install
