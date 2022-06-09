{ version = "1.0.0"
, author = "Phil de Joux"
, maintainer = "phil.dejoux@blockscope.com"
, copyright = "© 2020-2022 Phil de Joux, © 2020-2022 Block Scope Limited"
, git = "https://github.com/BlockScope/ghc-corroborate.git"
, bug-reports = "https://github.com/blockscope/ghc-corroborate/issues"
, license = "MPL-2.0"
, license-file = "LICENSE.md"
, tested-with =
    "GHC == 8.0.2, GHC == 8.2.2, GHC == 8.4.4, GHC == 8.6.5, GHC == 8.8.4, GHC == 8.10.7, GHC == 9.0.2, GHC == 9.2.3"
, ghc-options =
  [ "-Wall"
  , "-Wincomplete-uni-patterns"
  , "-Wcompat"
  , "-Widentities"
  , "-Wredundant-constraints"
  ]
, dependencies = [ "base >=4.9.1.0 && <5" ]
}
