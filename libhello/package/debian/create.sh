#!/bin/bash

set -e

pkgname=libhello

if [[ -v GITHUB_REF ]]; then
  branch_name=$(echo $GITHUB_REF | sed 's:[^/]*/[^/]*/\([^\]*\):\1:g')
else
  branch_name=$(git symbolic-ref --short HEAD)
fi

pkgname_sufix="-$branch_name"

pkgver=0.1.0

commit_sha=$(git rev-parse HEAD)

output_dir=source-package

echo "Source package directory: $output_dir"
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

cd "$output_dir"

wget -q \
  "https://github.com/tarberd/cmake-project-template/archive/$commit_sha.tar.gz" \
  -O "$pkgname-$pkgver.tar.gz"

tar -xzf "$pkgname-$pkgver.tar.gz"

mv "cmake-project-template-$commit_sha" "$pkgname-$pkgver"
cd "$pkgname-$pkgver"

DEBEMAIL="bernardo.mferrari@gmail.com"
DEBFULLNAME="Bernardo Ferrari"
export DEBEMAIL DEBFULLNAME

debmake \
  --package $pkgname \
  --upstreamversion $pkgver \
  -b"$pkgname$pkgname_sufix-$pkgver:lib,$pkgname$pkgname_sufix-dev:dev"

cd debian

rm -r patches
rm 'source/local-options'
rm clean
rm README.Debian
rm *.docs *.doc-base *.examples *.info *.links *.manpages *.postinst *.postrm *.preinst *.prerm

# config control file
sed -e 's/Section: unknown/Section: libs/g' -i control
# config rules file
cat ../../../debian.in/rules > rules
# config install files
cat ../../../debian.in/lib.install > "$pkgname$pkgname_sufix-$pkgver.install"
cat ../../../debian.in/lib-dev.install > "$pkgname$pkgname_sufix-dev.install"
# config changelog file
