#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Patch
# Fix synchronization issues with Perl 5.28.0
patch -Np1 -i "${SHED_PKG_PATCH_DIR}/0001-Update-locale-handling-for-Perl-5.28.patch" || exit 1
# Configure
SHED_PKG_LOCAL_PREFIX='/usr'
SHED_PKG_LOCAL_STATIC_OPTION='--disable-static'
if [ -n "${SHED_PKG_LOCAL_OPTIONS[toolchain]}" ]; then
    SHED_PKG_LOCAL_PREFIX='/tools'
    SHED_PKG_LOCAL_STATIC_OPTION=''
fi
./configure --prefix=${SHED_PKG_LOCAL_PREFIX} \
            ${SHED_PKG_LOCAL_STATIC_OPTION} &&

# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
