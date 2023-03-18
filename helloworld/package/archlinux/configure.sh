#!/bin/bash

set -e

if [[ -v GITHUB_REF ]]; then
  branch_name=$(echo $GITHUB_REF | sed 's:[^/]*/[^/]*/\([^\]*\):\1:g')
else
  branch_name=$(git symbolic-ref --short HEAD)
fi

pkgname_sufix="-$branch_name"

echo "Package name sufix: $pkgname_sufix"

pkg_version=$(set -o pipefail
  git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
)

echo "Version: $pkg_version"

sha=$(git rev-parse HEAD)

echo "SHA: $sha"

output_dir=source-package

echo "Configured source package directory: $output_dir"
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

sed -e "s/%pkgname-sufix%/$pkgname_sufix/g" \
    -e "s/%pkg-version%/$pkg_version/g" \
    -e "s/%sha%/$sha/g" \
    < PKGBUILD.in > "$output_dir/PKGBUILD"

cd "$output_dir"
md5sums=$(makepkg -g)

mv PKGBUILD PKGBUILD.md5sums

sed -e "s/md5sums\=('SKIP')/$md5sums/g" \
    < PKGBUILD.md5sums > PKGBUILD

rm PKGBUILD.md5sums

echo "md5sums: $md5sums"
