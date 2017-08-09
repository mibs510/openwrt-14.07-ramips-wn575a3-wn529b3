# openwrt-14.07-ramips-wn575a3-wn529b3
This page serves two things: 
   * A ready-to-flash vanilla 14.07 OpenWrt image: `openwrt-14.07-ramips-wn575a3-wn529b3-squashfs.bin`
   * A simple system of repacking your own customized tftp uploadable `firmware.bin` file

# Supported Devices
Most inexpensive chinese wireless access points which run off of a MediaTek MT7628AN & MT7612EN

# More use(ful/less) information
[OpenWRT for WS-WN529B3](http://osmar.gonzal.us/openwrt-ws-wn529b3/#more-278) & [OpenWRT for WL-WN575A3](http://osmar.gonzal.us/openwrt-for-wl-wn575a3/#more-189)

# BIG thanks to
[mqmaker.com](https://mqmaker.com/) for the wonderful OpenWrt make source found [here](https://github.com/mqmaker/witi-openwrt).

# Default IP Address
192.168.1.1

# Flashing
TFTP method is typically the way one should flash images on these devices.
Even if the stock firmware contains `sysupgrade` the side effects of using it are unkown.
Refer to the "TFTP" section on [this page](https://wiki.openwrt.org/toh/wavlink/wl-wn575a3) for detailed tftp flashing instructions.

# Bootloader
You may or may not have a bootloader allowing firmware downloads via tftp or writing upon downloading, this varies from device to device, model to model, brand to brand.
One thing I've noticed is that there is no sure way to tell wether your device will be unlocked or locked before purchasing, WAVLINK/WINSTARS will dictate that.
A guide will soon be posted shortly ([here](http://osmar.gonzal.us/rewriting-mt7628an-bootloader)) guiding you through a non-physical way of rewriting your bootloader. 

# Before you repack.sh
If you don't already have `mksquashfs` or `padjffs2` you can get them both from [here](https://github.com/rssnsj/firmware-tools).

# /etc/wireless/mt7628/mt7628.dat
LuCI or uci2dat (I havent figured out who is responsible yet) *may* rewrite `CountryCode=CN` in /etc/wireless/mt7628/mt7628.dat:6 .
In such case `CountryCode` must always equal to `CN` for the 2.4 GHz radio to work properly regardless of your actual location.
This will usually occur when you find yourself not being able to see the ESSID.

# /etc/opkg.conf
Yes we're stuck on using the `mt7620a`'s packages since OpenWrt doesn't provide explicit `mt7628` packages anymore, at least not on the 14.07 branch.



