#!/bin/sh

HOMEDIR=${HOME}/work/dicom3tools 
SRCDIR=images/dicom/forjpeg2000/discimg
TMPDIR=/tmp

#COMPRESSOR=$HOMEDIR/appsrc/misc/rawnjl2
COMPRESSOR=./rawnjl2

docodec() {	# docodec name rows cols depth
	echo $1 $2 $3 $4
	dctoraw $HOMEDIR/$SRCDIR/$1 $TMPDIR/$1.raw
	echo Compressing ...
	$COMPRESSOR    -rows $2 -columns $3 -depth $4 -input-endian little $TMPDIR/$1.raw $TMPDIR/$1.jls
	echo Decompressing ...
	$COMPRESSOR -d -output-endian little $TMPDIR/$1.jls $TMPDIR/$1.cmp
	echo Comparing ...
	cmp $TMPDIR/$1.raw $TMPDIR/$1.cmp
	echo Done
	ls -l $TMPDIR/$1.raw $TMPDIR/$1.jls $TMPDIR/$1.cmp
	rm $TMPDIR/$1.raw $TMPDIR/$1.jls $TMPDIR/$1.cmp
}


docodec CT1  512  512 16
docodec CT2  512  512 16
docodec MG1 4664 3064 12
docodec MR1  512  512 16
docodec MR2 1024 1024 12
docodec MR3  512  512 16
docodec MR4  512  512 12
docodec NM1 1024  256 16
docodec RG1 1955 1841 15
docodec RG2 2140 1760 10
docodec RG3 1760 1760 10
docodec XA1 1024 1024 10
docodec SC1 2487 2048 12

