#!/bin/sh

#set +v

stack install build-ghc-corroborate
build-ghc-corroborate $@
