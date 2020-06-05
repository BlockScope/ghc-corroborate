    let defs = ./../defaults.dhall

in  let testopts = [ "-rtsopts", "-threaded", "-with-rtsopts=-N" ]

in    defs
    ⫽ { name =
          "units-quantity"
      , synopsis =
          "Units of measure as a GHC typechecker plugin"
      , description =
          ''
          The @uom-plugin@ library adds support for units of measure to GHC
          using the new experimental facility for typechecker plugins, which
          is available in GHC 7.10 and later.  See
          "Data.UnitsOfMeasure.Tutorial" for an introduction to the library.''
      , category =
          "Type System"
      , github =
          "adamgundry/uom-plugin"
      , license =
          "BSD3"
      , license-file =
          "LICENSE"
      , stability =
          "experimental"
      , extra-source-files =
          [ "README.md", "LICENSE" ]
      , library =
          { source-dirs =
              [ "src" ]
          , dependencies =
                defs.dependencies
              # [ "deepseq >=1.3 && <1.5"
                , "template-haskell >=2.9"
                , "containers >=0.5"
                , "ghc-corroborate"
                , "units-parser >=0.1"
                ]
          , exposed-modules =
              [ "GHC.Corroborate.Type"
              , "Data.UnitsOfMeasure.Quantity"
              , "Data.UnitsOfMeasure.Read"
              , "Data.UnitsOfMeasure.Show"
              , "Data.UnitsOfMeasure.Singleton"
              , "Data.UnitsOfMeasure.Unsafe"
              , "Data.UnitsOfMeasure.Unsafe.Convert"
              , "Data.UnitsOfMeasure.Unsafe.Unify"
              ]
          , other-modules =
              "Data.UnitsOfMeasure.Unsafe.NormalForm"
          }
      , when =
          [ { condition =
                "impl(ghc >= 8.10.0)"
            , source-dirs =
                "src-ghc-8.10"
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
                "src-ghc-8.8"
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
                "src-ghc-8.6"
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
                "src-ghc-8.4"
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
                "src-ghc-8.2"
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
                "src-ghc-8.0"
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
      , tests =
          { hlint =
              { dependencies =
                  "base"
              , ghc-options =
                  testopts
              , main =
                  "HLint.hs"
              , source-dirs =
                  "test-suite-hlint"
              , when =
                  [ { condition =
                        "impl(ghc >= 8.6.0)"
                    , dependencies =
                        "hlint"
                    , buildable =
                        True
                    }
                  , { condition =
                        "impl(ghc >= 8.4.0) && impl(ghc < 8.6.0)"
                    , dependencies =
                        "hlint < 2.1.18"
                    , buildable =
                        True
                    }
                  , { condition =
                        "impl(ghc < 8.4.0)"
                    , dependencies =
                        "hlint"
                    , buildable =
                        False
                    }
                  ]
              }
          }
      }
