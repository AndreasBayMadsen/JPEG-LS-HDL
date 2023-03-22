#!/bin/sh

DCTOOLDIR=${HOME}/work/dicom3tools

ln -s $DCTOOLDIR/appsrc/misc/rawnjl2.cc
(cd man/man1; ln -s $DCTOOLDIR/appsrc/misc/rawnjl2.man rawnjl2.1)
(cd man/man1; ln -s $DCTOOLDIR/man/man1/binin.so)
(cd man/man1; ln -s $DCTOOLDIR/man/man1/binout.so)

ln -s $DCTOOLDIR/libsrc/include/generic/basetype.h
ln -s $DCTOOLDIR/libsrc/include/generic/endtype.h
ln -s $DCTOOLDIR/libsrc/include/generic/strtype.h
ln -s $DCTOOLDIR/libsrc/include/generic/bnstream.h
ln -s $DCTOOLDIR/libsrc/include/generic/bnopt.h
ln -s $DCTOOLDIR/libsrc/include/generic/getoptns.h
ln -s $DCTOOLDIR/libsrc/include/generic/errclass.h
ln -s $DCTOOLDIR/libsrc/include/locale/mesgtext.h

ln -s $DCTOOLDIR/libsrc/src/generic/getoptns.cc
ln -s $DCTOOLDIR/libsrc/src/generic/bnopti.cc
ln -s $DCTOOLDIR/libsrc/src/generic/bnopto.cc
ln -s $DCTOOLDIR/libsrc/src/locale/mesgtext.cc
ln -s $DCTOOLDIR/libsrc/src/locale/mesgttbl.h


