#!/bin/sh

#set +v

stack install build-plugins-for-blobs
build-plugins-for-blobs $@
