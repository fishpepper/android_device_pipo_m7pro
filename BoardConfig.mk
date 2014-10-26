USE_CAMERA_STUB := true

# inherit from the proprietary version
-include vendor/pipo/m7pro/BoardConfigVendor.mk

TARGET_ARCH := arm
TARGET_NO_BOOTLOADER := true


TARGET_BOARD_PLATFORM := unknown
TARGET_BOARD_HARDWARE := m7pro
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_HAVE_VFP := true
ARCH_ARM_HAVE_NEON := true
ARCH_ARM_HAVE_ARMV7A := true

#? BOARD_USE_LCDC_COMPOSER := false

TARGET_BOOTLOADER_BOARD_NAME := rk30board
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

BOARD_KERNEL_CMDLINE := console=ttyFIQ0 androidboot.console=ttyFIQ0 init=/init initrd=0x62000000,0x00800000 mtdparts=rk29xxnand:0x00002000@0x00002000(misc),0x00006000@0x00004000(kernel),0x00006000@0x0000A000(boot),0x00010000@0x00010000(recovery),0x00020000@0x00020000(backup),0x00040000@0x00040000(cache),0x00400000@0x00080000(userdata),0x00002000@0x00480000(kpanic),0x00140000@0x00482000(system),-@0x005C2000(user)

BOARD_RAMDISK_BASE := 0x62000000
BOARD_KERNEL_BASE  := 0x60400000
BOARD_KERNEL_PAGESIZE := 4096

# fix this up by examining /proc/mtd on a running device
# TRY THIS: http://whiteboard.ping.se/Android/Unmkbootimg
#mtd0:  00400000 00004000 "misc"
#mtd1:  00c00000 00004000 "kernel"
#mtd2:  00c00000 00004000 "boot"
#mtd3:  02000000 00004000 "recovery"
#mtd4:  04000000 00004000 "backup"
#mtd5:  08000000 00004000 "cache"
#mtd6: 1c0000000 00004000 "userdata"
#mtd7:  00400000 00004000 "metadata"
#mtd8:  00400000 00004000 "kpanic"
#mtd9:  28000000 00004000 "system"
#mtd10:1c8000000 00004000 "user"a
#
#cat /proc/partitions                                           
#major minor  #blocks  name
#
#  31        0       4096 mtdblock0
#  31        1      12288 mtdblock1
#  31        2      12288 mtdblock2
#  31        3      32768 mtdblock3
#  31        4      65536 mtdblock4
#  31        5     131072 mtdblock5
#  31        6    7340032 mtdblock6
#  31        7       4096 mtdblock7
#  31        8       4096 mtdblock8
#  31        9     655360 mtdblock9
#  31       10    7471104 mtdblock10
#
BOARD_BOOTIMAGE_PARTITION_SIZE     := 12582912          #0x000c00000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432          #0x002000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 671088640         #0x028000000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 7516192768        #0x1c0000000
BOARD_FLASH_BLOCK_SIZE := 131072

#set up the flash file formats so that we can flash them directly
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_SYSTEM_FILESYSTEM    := ext4
#ext4 bigger than 2gb?
BOARD_HAS_LARGE_FILESYSTEM := true

TARGET_EXTRA_CFLAGS += $(call cc-option,-mtune=cortex-a9,$(call cc-option,-mtune=cortex-a8)) $(call cc-option,-mcpu=cortex-a9,$(call cc-option,-mcpu=cortex-a8))

BOARD_HAS_NO_SELECT_BUTTON := true

PRODUCT_CHARACTERISTICS := tablet
PRODUCT_PROPERTY_OVERRIDES += sys.device.type=tablet

BOARD_EGL_CFG := device/pipo/m7pro/pipo_rom/extracted/system/lib/egl/egl.cfg
USE_OPENGL_RENDERER := true
BOARD_USES_HGL := true
BOARD_USES_OVERLAY := true
TARGET_USES_ION := true

# Wifi
BOARD_HAVE_WIFI := true
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER	:= NL80211
BOARD_HOSTAPD_PRIVATE_LIB	:= lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := bcmdhd
#RK901 is actually a BCM40181 - Broadcom 4329 Based Chipset!
WIFI_DRIVER_FW_PATH_PARAM	:= "/system/etc/firmware/fw_RK901.bin"
WIFI_DRIVER_FW_PATH_P2P	:= "/system/etc/firmware/fw_RK901_p2p.bin"
WIFI_DRIVER_FW_PATH_AP	:= "/system/etc/firmware/fw_RK901_apsta.bin"
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/rkwifi.ko"
WIFI_DRIVER_MODULE_NAME := "wlan"

#bluetooth
BOARD_HAVE_BLUETOOTH := true

