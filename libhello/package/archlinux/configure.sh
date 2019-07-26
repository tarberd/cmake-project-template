
branch_name=$(git symbolic-ref --short HEAD)

echo "Branch name: $branch_name"

pkg_version=$(set -o pipefail
  git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
  printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
)

echo "Version: $pkg_version"

sha=$(git rev-parse HEAD)

echo "SHA: $sha"

sed -e "s/%branch-name%/$branch_name/g" \
    -e "s/%pkg-version%/$pkg_version/g" \
    -e "s/%sha%/$sha/g" \
    < PKGBUILD.in > PKGBUILD
