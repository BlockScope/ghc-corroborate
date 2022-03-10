let defs = ./defaults.dhall

in  let testopts = [ "-rtsopts", "-threaded", "-with-rtsopts=-N" ]

    in    defs
        ⫽ { name = "ghc-corroborate"
          , synopsis = "An flatter API for GHC typechecker plugins"
          , description =
              ''
              The GHC API changes over time. This package re-exports most GHC
                        imports needed by typechecker plugins from its GHC.Corroborate module
                        with a stable API over multiple GHC versions.''
          , category = "Type System, GHC, Plugin"
          , github = "blockscope/ghc-corroborate"
          , stability = "experimental"
          , extra-source-files =
            [ "README.md", "LICENSE.md", "defaults.dhall", "package.dhall" ]
          , library =
            { dependencies = defs.dependencies # [ "ghc-tcplugins-extra" ]
            , exposed-modules =
              [ "GhcApi.Constraint"
              , "GhcApi.Predicate"
              , "GhcApi.GhcPlugins"
              , "GHC.Corroborate.Constraint"
              , "GHC.Corroborate.Evidence"
              , "GHC.Corroborate.Compare"
              , "GHC.Corroborate.Shim"
              , "GHC.Corroborate.Wrap"
              , "GHC.Corroborate.Divulge"
              , "GHC.Corroborate"
              ]
            , other-modules = [] : List Text
            , when =
              [ { condition = "impl(ghc >= 9.2) && impl(ghc < 9.4)"
                , source-dirs = [ "src-ghc-tree", "src-ghc-9.2" ]
                , dependencies =
                  [ { name = "ghc"
                    , version = ">=9.2 && <9.4"
                    , mixin = [] : List Text
                    }
                  ]
                }
              , { condition = "impl(ghc >= 9.0) && impl(ghc < 9.2)"
                , source-dirs = [ "src-ghc-tree", "src-ghc-9.0" ]
                , dependencies =
                  [ { name = "ghc"
                    , version = ">=9.0 && <9.2"
                    , mixin = [] : List Text
                    }
                  ]
                }
              , { condition = "impl(ghc >= 8.10.0) && impl(ghc < 9.0)"
                , source-dirs = [ "src-ghc-flat", "src-ghc-8.10" ]
                , dependencies =
                  [ { name = "ghc"
                    , version = ">=8.10 && <8.12"
                    , mixin = [] : List Text
                    }
                  ]
                }
              , { condition = "impl(ghc >= 8.8.0) && impl(ghc < 8.10.0)"
                , source-dirs = [ "src-ghc-flat", "src-ghc-8.8" ]
                , dependencies =
                  [ { name = "ghc"
                    , version = ">=8.8 && <8.10"
                    , mixin =
                      [ "hiding ()"
                      , "(TcRnTypes as TcRnTypes)"
                      , "(Type as Type)"
                      , "(TcRnTypes as Constraint)"
                      , "(Type as Predicate)"
                      ]
                    }
                  ]
                }
              , { condition = "impl(ghc >= 8.6.0) && impl(ghc < 8.8.0)"
                , source-dirs = [ "src-ghc-flat", "src-ghc-8.6" ]
                , dependencies =
                  [ { name = "ghc"
                    , version = ">=8.6 && <8.8"
                    , mixin =
                      [ "hiding ()"
                      , "(TcRnTypes as TcRnTypes)"
                      , "(Type as Type)"
                      , "(TcRnTypes as Constraint)"
                      , "(Type as Predicate)"
                      ]
                    }
                  ]
                }
              , { condition = "impl(ghc >= 8.4.0) && impl(ghc < 8.6.0)"
                , source-dirs = [ "src-ghc-flat", "src-ghc-8.4" ]
                , dependencies =
                  [ { name = "ghc"
                    , version = ">=8.4 && <8.6"
                    , mixin =
                      [ "hiding ()"
                      , "(TcRnTypes as TcRnTypes)"
                      , "(Type as Type)"
                      , "(TcRnTypes as Constraint)"
                      , "(Type as Predicate)"
                      ]
                    }
                  ]
                }
              , { condition = "impl(ghc >= 8.2.0) && impl(ghc < 8.4.0)"
                , source-dirs = [ "src-ghc-flat", "src-ghc-8.2" ]
                , dependencies =
                  [ { name = "ghc"
                    , version = ">=8.2 && <8.4"
                    , mixin =
                      [ "hiding ()"
                      , "(TcRnTypes as TcRnTypes)"
                      , "(Type as Type)"
                      , "(TcRnTypes as Constraint)"
                      , "(Type as Predicate)"
                      ]
                    }
                  ]
                }
              , { condition = "impl(ghc >= 8.0.0) && impl(ghc < 8.2.0)"
                , source-dirs = [ "src-ghc-flat", "src-ghc-8.0" ]
                , dependencies =
                  [ { name = "ghc"
                    , version = ">=8.0 && <8.2"
                    , mixin =
                      [ "hiding ()"
                      , "(TcRnTypes as TcRnTypes)"
                      , "(Type as Type)"
                      , "(TcRnTypes as Constraint)"
                      , "(Type as Predicate)"
                      ]
                    }
                  ]
                }
              ]
            }
          }
