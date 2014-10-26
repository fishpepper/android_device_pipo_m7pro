if [ ! -x rkflashtool/rkflashtool ]; then
	git clone git://git.code.sf.net/p/rkflashtool/Git rkflashtool
	cd rkflashtool
	make
	cd ..
fi;

./custom_boot.sh

#check connection
./rkflashtool/rkflashtool p || {echo "rkflashtool can not connect. please make sure device is in bootloader mode!"; exit 0};

#check if the 
#my m7pro shows:
#CMDLINE:console=ttyFIQ0 androidboot.console=ttyFIQ0 init=/init initrd=0x62000000,0x00800000 mtdparts=rk29xxnand:0x00002000@0x00002000(misc),0x00006000@0x00004000(kernel),0x00006000@0x0000a000(boot),0x00010000@0x00010000(recovery),0x00020000@0x00020000(backup),0x00040000@0x00040000(cache),0x00e00000@0x00080000(userdata),0x00002000@0x00e80000(metadata),0x00002000@0x00e82000(kpanic),0x00140000@0x00e84000(system),-@0x00fc4000(user)"
MD5SUM_OK="d8493c1466fe36ae33a7885acb378068"
MD5SUM_CALC=`./rkflashtool/rkflashtool p|grep CMDLINE|md5sum`

if [ ! "$MD5SUM_CALC" != "$MD5SUM_OK" ]; then
	echo "> ERROR: your cmdline extracted with rkflashtool p does not match what i expected to see"
	echo "> please manually check the nand adresses for the partitions and modify the rkflashtool w calls !"
	echo "> IF YOU DO NOT FIX THAT YOU CAN BRICK YOUR TABLET!"
	exit 0
fi

./rkflashtool/rkflashtool w 0xa000 0x6000 < boot.img 
./rkflashtool/rkflashtool w 0xe84000 0x140000 < system.img
./rkflashtool/rkflashtool w 0x4000 0x6000 < kernel.img
echo "will reboot in 5sec..."
sleep 5
./rkflashtool/rkflashtool b
