#!/bin/bash

set -e

branch_name="test"

echo "Branch name: $branch_name"

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

sed -e "s/%branch-name%/$branch_name/g" \
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
