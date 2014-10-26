#!/bin/bash

#cd $OUT
rm boot.img
#rm recovery.img
pushd root/
chmod g-w -R *
find . | cpio -o -H newc | gzip -n > ../boot.gz
popd

#pushd recovery/root/
#chmod g-w -R *
#find . | cpio -o -H newc | gzip -n > ../../recovery.gz
#popd

#check if rktools is available:
RKCRC="rkcrc"
if ! command -v $RKCRC > /dev/null; then
	#ok, not installed system wide, check if we already built it:
	echo "rkcrc not installed on system, will use my own version"
	RKCRC="rktools/rkcrc"
	if [ ! -x $RKCRC ]; then
		#oh we did not build it yet, lets do that:
		echo "rkcrc was not built yet, fetching archive and building it"
		git clone https://github.com/rk3066/rk-tools.git rktools
		cd rktools
		make
		cd ..
	fi;
fi;

if  ! command -v $RKCRC > /dev/null; then
	echo "something went wrong, rkcrc still not available..."
	exit 1
fi;


#$RKCRC -k recovery.gz recovery.img
$RKCRC -k boot.gz boot.img
$RKCRC -k kernel kernel.img

rm boot.gz
#rm recovery.gz

exit 0

