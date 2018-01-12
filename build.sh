#!/bin/bash
case "$SHED_BUILDMODE" in
    toolchain)
        ./configure --prefix=/tools || return 1
        ;;
    *)
        ./configure --prefix=/usr \
                    --disable-static || return 1
        ;;
esac
make -j $SHED_NUMJOBS || return 1
make DESTDIR="$SHED_FAKEROOT" install || return 1
