testing cm11 port to pipo m7 pro

this is work in progress!

what is working?
- wifi: tested, authenticating and browsing the web works
- bluetooth: tested scanning, finds devices and is visible (not tested more) [BUG: it was working once, now it does not work anymore...]
- camera: both working
- internal storage / sd storage and usb storage work
- Sensors tested with AndroSensor: battery, accel, gyro, compass (akmd needs to be running)

what is not working?
- gps is not working yet
- sound (system sounds work, apps not tested yet)

NOT tested:
- GSM module (mine does not have it)

TO TEST:
- light sensor

FOR THE HACKERS
=============================
There is a serial debug port on the main PCB next to the power jack.
Its labeled RX, TX, GND. You can directly connect a FT232-3V3 (3.3V type! The 5V type will kill the board)
serial usb converter cable to it. Use 115200 8N1 not flow control.
There is also a shell on that.

HOW TO BUILD
=============================

1)
set up a plain cm11 build tree (see cm doc)

2) import the local manifest:
git clone https://github.com/fishpepper/android_device_pipo_m7pro.git devices/pipo/m7pro
cp devices/pipo/m7pro/manifest/m7pro.xml .repo/local_manifests/

3) download the rom from pipo:
http://www.mediafire.com/download/vsl4l9hstydb2yj/M7_pro_3G_&_NO_3G_Chinese_4.4_20140326.rar
Place it in the source tree under devices/pipo/m7pro/pipo_rom/20140326.rar
run./fetch_prebuilts.sh

This will extract all binary blobs from that rom

4) build the source by calling brunch m7pro

HOW TO FLASH
=============================

right now i did not test cwm installer based installation,
i used rkflash to flash it.

DO THIS ON YOUR OWN RISK!!!!

0) boot into flashloader: shut down tablet by long press. press and hold ESC while
pressing power on for 5-8s. Then release both.

1) verify that your board is the same as mine by running > rkflashtool p
FIRMWARE_VER:4.4.2
MACHINE_MODEL:M7pro
MACHINE_ID:007
MANUFACTURER:RK30SDK
MAGIC: 0x5041524B
ATAG: 0x60000800
MACHINE: 3066
CHECK_MASK: 0x80
KERNEL_IMG: 0x60408000
#RECOVER_KEY: 1,1,0,20,0
CMDLINE:console=ttyFIQ0 androidboot.console=ttyFIQ0 init=/init initrd=0x62000000,0x00800000 mtdparts=rk29xxnand:0x00002000@0x00002000(misc),0x00006000@0x00004000(kernel),0x00006000@0x0000a000(boot),0x00010000@0x00010000(recovery),0x00020000@0x00020000(backup),0x00040000@0x00040000(cache),0x00e00000@0x00080000(userdata),0x00002000@0x00e80000(metadata),0x00002000@0x00e82000(kpanic),0x00140000@0x00e84000(system),-@0x00fc4000(user)

2) verify the adresses for boot and system location (swap address before and after the @)
0x00006000@0x0000a000(boot)
0x00140000@0x00e84000(system)

3) flash the images (this will reboot after flashing):
./flash.sh

NOTE: the flash.sh script checking the md5sum is currently untested

(do not worry about the premature warning at boot.img, our image is smaller)

