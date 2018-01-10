#!/bin/bash
./configure --prefix=/usr \
            --disable-static || return 1
make -j $SHED_NUMJOBS || return 1
make DESTDIR="$SHED_FAKEROOT" install || return 1
