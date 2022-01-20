#!/usr/bin/env bash
# Get an updated config.sub and config.guess
find . -name config.sub -print -exec cp "$BUILD_PREFIX"/share/gnuconfig/config.sub {} \;
find . -name config.guess -print -exec cp "$BUILD_PREFIX"/share/gnuconfig/config.guess {} \;
set -euo pipefail
IFS=$'\n\t'

# Workaround from: https://github.com/gridcf/gct/issues/79#issuecomment-486323795
( cd gsi_openssh/source; aclocal; autoheader; autoconf )

# Remove pam
sed -i 's@--with-pam @@g' gsi_openssh/source/configure.gnu

# Fix up the shebangs to use conda's perl
grep -rlE '/usr/bin/perl' . | xargs -I _ sed -i.bak '1s@/usr/bin/perl@/usr/bin/env perl@' _

./configure \
    --prefix="${PREFIX}" \
    --includedir="${PREFIX}/include/globus" \
    --libexecdir="${PREFIX}/share/globus"

make -j${CPU_COUNT}
make install
