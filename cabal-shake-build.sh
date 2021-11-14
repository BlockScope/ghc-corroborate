#!/bin/sh

#set +v

cabal v2-build build-plugins-for-blobs
exec cabal v2-run build-plugins-for-blobs -- "$@"