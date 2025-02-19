#!/usr/bin/env bash

set -veuo pipefail

# Generate build info
rel_date="$(date "+%Y%m%d")" # ISO 8601 format
rel_friendly_date="$(date "+%B %-d, %Y")" # "Month day, year" format
clang_version="$(install/bin/clang --version | head -n1 | cut -d' ' -f4)"

# Generate release info
builder_commit="$(git rev-parse HEAD)"
pushd llvm-project
llvm_commit="$(git rev-parse HEAD)"
short_llvm_commit="$(cut -c-8 <<< $llvm_commit)"
popd

llvm_commit_url="https://github.com/llvm/llvm-project/commit/$llvm_commit"
binutils_ver="$(ls | grep "^binutils-" | sed "s/binutils-//g")"

# Update Git repository
git clone "https://Stealth1226:$GH_TOKEN@github.com/stealth1226/stealth-clang" rel_repo
pushd rel_repo
rm -fr *
cp -r ../install/* .
# Keep files that aren't part of the toolchain itself
git checkout README.md LICENSE
git add .
git commit -am "Update to $rel_date build

LLVM commit: $llvm_commit_url
binutils version: $binutils_ver
git push
popd
