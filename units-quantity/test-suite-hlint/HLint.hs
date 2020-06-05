module Main (main) where

import Language.Haskell.HLint (hlint)
import System.Exit (exitFailure, exitSuccess)

arguments :: [String]
arguments =
    [ "lint"
    , "--ignore=Parse error"
    , "src"
    , "src-ghc-8.10"
    , "src-ghc-8.8"
    , "src-ghc-8.6"
    , "src-ghc-8.4"
    , "src-ghc-8.2"
    , "src-ghc-8.0"
    ]

main :: IO ()
main = do
    hints <- hlint arguments
    if null hints then exitSuccess else exitFailure
