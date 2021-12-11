#!/bin/sh

#set +v

cabal v2-build build-ghc-corroborate
exec cabal v2-run build-ghc-corroborate -- "$@"