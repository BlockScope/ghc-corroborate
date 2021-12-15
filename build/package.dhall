  ./../defaults.dhall
⫽ { name = "build-ghc-corroborate"
  , synopsis = "A shake build of ghc-corroborate."
  , description = "Builds the ghc-corroborate package."
  , category = "Build"
  , executables.build-ghc-corroborate
    =
    { dependencies =
      [ "base", "ansi-terminal", "shake", "raw-strings-qq", "text", "time" ]
    , ghc-options = [ "-rtsopts", "-threaded", "-with-rtsopts=-N" ]
    , main = "Main.hs"
    , source-dirs = "."
    }
  }
