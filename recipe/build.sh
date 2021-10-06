#!/usr/bin/env bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/jobmanager/lrms/fork/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/authz/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/gssapi/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gridftp/server-lib/src/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./io/compat/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gridftp/server/src/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/gridmap_callout/error/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/gssapi_error/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./xio/drivers/rate/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/credential/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/callback/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/jobmanager/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/authz/error/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/jobmanager/lrms/lsf/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/jobmanager/lrms/pbs/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/client/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/gatekeeper/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./xio/drivers/gsi/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gridftp/net_manager/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/proxy/proxy_ssl/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/simple_ca/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gridftp/server/multi/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gridftp/control/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/gridmap_callout/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./xio/drivers/popen/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/client_tools/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/gridmap_eppn_callout/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/protocol/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/rsl/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./common/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/gridmap_verify_myproxy_callout/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/proxy/proxy_utils/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/cert_utils/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/sysconfig/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi_openssh/source
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/gss_assist/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/jobmanager/callout_error/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./xio/drivers/pipe/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gridftp/client/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./xio/src/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gridftp/gridftp_driver/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gass/copy/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./myproxy/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gass/server_ez/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./xio/drivers/udt/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./xio/xioperf/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/jobmanager/lrms/sge/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./callout/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gass/cache/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gram/jobmanager/scheduler_event_generator/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gridftp/gfork/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gass/transfer/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gridftp/hdfs/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/openssl_module/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/openssl_error/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gass/cache_program/source/build-aux
cp $BUILD_PREFIX/share/gnuconfig/config.* ./gsi/proxy/proxy_core/source/build-aux
set -euo pipefail
IFS=$'\n\t'

# Workaround from: https://github.com/gridcf/gct/issues/79#issuecomment-486323795
( cd gsi_openssh/source; aclocal; autoheader; autoconf )

# Fix up the shebangs to use conda's perl
grep -rlE '/usr/bin/perl' . | xargs -I _ sed -i.bak '1s@/usr/bin/perl@/usr/bin/env perl@' _

./configure \
    --prefix="${PREFIX}" \
    --includedir="${PREFIX}/include/globus" \
    --libexecdir="${PREFIX}/share/globus"

make -j${CPU_COUNT}
make install
