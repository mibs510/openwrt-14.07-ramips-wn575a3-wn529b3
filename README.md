# openwrt-14.07-ramips-wn575a3-wn529b3
Project page: [OpenWRT for WS-WN529B3](http://osmar.gonzal.us/openwrt-ws-wn529b3/) & [OpenWRT for WL-WN575A3](http://osmar.gonzal.us/openwrt-for-wl-wn575a3/)
# Default IP Address
192.168.10.1
# What works
Mostly everything besides being able to change the encryption type on the two radios, it's limited to "No Encryption", "WEP Open System", and "WEP Shared Key"
# SSH
SSH is enabled on **port 22**, with a username of **root** and a password of **toor**. 
# Packages
This project will be a work in progress. There were already many pre-installed packages but no opkg tracking methods were intact in /usr/lib/opkg/info/* 
infact opkg was completely removed from the file system. All of the files found in a typical /usr/lib/opkg/info/* were copied over for opkg to function
normally regardless if the root filesystem actually contains each file in the repective *.list file.
# What needs work
1. Obvisouly encryption

   * That's our biggest priority since the stock firmware gave us the same freedom when it came editing radio settings.
2. The entire network stack

   * Right now /bin/mu is responsible for bringing up all network interfaces including udhcpc, dnsmasq, and miniupnpd. 
   * Simply removing /bin/mu, /etc/rc.d/S90mu, /etc/init.d/mu and replacing them with the repective rc.d links, init.d scripts, and binaries of odhcpd, odhcp6c, dnsmaq does not solve this issue.
   * Probable need to further examine the default web interface, and how it functions. 
3. The package system

# Bootloader
The binary includes an official WN529B3 uImage kernel so there is no need for an unlocked bootloader on both devices.

# Prereqs
If you don't already have `mksquashfs` or `padjffs2` you can get them both from [here](https://github.com/rssnsj/firmware-tools).

# 802.11 Encryption
Although in luci you're not able to edit the encryption mode of the radios, uci is able to change it and the commits are effective upon rebooting. For more details refer to [this](https://wiki.openwrt.org/doc/uci/wireless/encryption).
## WPA2 (PSK)
`root@OpenWrt:~# uci set wireless.@wifi-iface[0].encryption=psk2`

`root@OpenWrt:~# uci set wireless.@wifi-iface[0].key="your_password"`

`root@OpenWrt:~# uci commit wireless`

`root@OpenWrt:~# reboot && exit`
