    let defs = ./defaults.dhall

in  let testopts = [ "-rtsopts", "-threaded", "-with-rtsopts=-N" ]

in    defs
    ⫽ { name =
          "ghc-tcplugins-api"
      , synopsis =
          "An API for GHC typechecker plugins"
      , description =
          "The GHC API changes over time. This package offers a consistent API."
      , category =
          "Type System"
      , github =
          "blockscope/ghc-tcplugins-api"
      , stability =
          "experimental"
      , extra-source-files =
          [ "README.md", "LICENSE.md", "defaults.dhall", "package.dhall" ]
      , library =
          { dependencies =
                defs.dependencies
              # [ "ghc-tcplugins-extra >=0.5" ]
          , exposed-modules =
              [ "GhcApi.Constraint"
              , "GhcApi.Predicate"
              , "GhcApi.GhcPlugins"
              , "Internal.Constraint"
              , "Internal.Evidence"
              , "Internal.Compare"
              , "Internal.Shim"
              , "Internal.Wrap"
              , "Internal"
              ]
          , other-modules =
              [] : List Text
          , when =
              [ { condition =
                    "impl(ghc >= 8.10.0)"
                , source-dirs =
                    [ "src-ghc", "src-ghc-8.10" ]
                , dependencies =
                    [ { name =
                          "ghc"
                      , version =
                          ">=8.10 && <8.12"
                      , mixin =
                          [] : List Text
                      }
                    ]
                }
              , { condition =
                    "impl(ghc >= 8.8.0) && impl(ghc < 8.10.0)"
                , source-dirs =
                    [ "src-ghc", "src-ghc-8.8" ]
                , dependencies =
                    [ { name =
                          "ghc"
                      , version =
                          ">=8.8 && <8.10"
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
              , { condition =
                    "impl(ghc >= 8.6.0) && impl(ghc < 8.8.0)"
                , source-dirs =
                    [ "src-ghc", "src-ghc-8.6" ]
                , dependencies =
                    [ { name =
                          "ghc"
                      , version =
                          ">=8.6 && <8.8"
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
              , { condition =
                    "impl(ghc >= 8.4.0) && impl(ghc < 8.6.0)"
                , source-dirs =
                    [ "src-ghc", "src-ghc-8.4" ]
                , dependencies =
                    [ { name =
                          "ghc"
                      , version =
                          ">=8.4 && <8.6"
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
              , { condition =
                    "impl(ghc >= 8.2.0) && impl(ghc < 8.4.0)"
                , source-dirs =
                    [ "src-ghc", "src-ghc-8.2" ]
                , dependencies =
                    [ { name =
                          "ghc"
                      , version =
                          ">=8.2 && <8.4"
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
              , { condition =
                    "impl(ghc >= 8.0.0) && impl(ghc < 8.2.0)"
                , source-dirs =
                    [ "src-ghc", "src-ghc-8.0" ]
                , dependencies =
                    [ { name =
                          "ghc"
                      , version =
                          ">=8.0 && <8.2"
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
