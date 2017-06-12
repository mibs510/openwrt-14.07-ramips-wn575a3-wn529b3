#!/bin/sh
append DRIVERS "mt7628"

. /lib/wifi/ralink_common.sh

prepare_mt7628() {
	prepare_ralink_wifi mt7628
}

scan_mt7628() {
	scan_ralink_wifi mt7628 mt7628
}


disable_mt7628() {
	disable_ralink_wifi mt7628
}

enable_mt7628() {
	enable_ralink_wifi mt7628 mt7628
}

detect_mt7628() {
#	detect_ralink_wifi mt7628 mt7628
	ssid=mt7628-`ifconfig eth0 | grep HWaddr | cut -c 51- | sed 's/://g'`
	cd /sys/module/
	[ -d $module ] || return
	[ -e /etc/config/wireless ] && return
	SSID_PREFIX=`sed -n /SSID/p /etc/firmware | awk -F "=" '{print $2}'`
	VENDOR=`sed -n /VENDOR/p /etc/firmware | awk -F "=" '{print $2}'`
	PRODUCT=`sed -n /PRODUCT/p /etc/firmware | awk -F "=" '{print $2}'`
	case $VENDOR in
	ZBT)
		SSID_SUFFIX=""
		;;
	BLINK)
		MAC=`cat /sys/class/net/eth0/address | awk -F ":" '{print $4""$5""$6 }'| tr a-z A-Z`
		SSID_SUFFIX="${MAC}"
		;;
	ANTBANG)
		MAC=`cat /sys/class/net/eth0/address | awk -F ":" '{print $4""$5""$6 }'| tr a-z A-Z`
		SSID_SUFFIX="${MAC}"
		;;
	WAVLINK)
		MAC=`cat /sys/class/net/eth0/address | awk -F ":" '{print ""$5""$6 }'| tr a-z A-Z`
		if [ "$PRODUCT" == "EN_B3" ];then
			SSID_SUFFIX="_N_${MAC}"
		else
			SSID_SUFFIX="${MAC}"
		fi
		;;
	*)
		MAC=`cat /sys/class/net/eth0/address | awk -F ":" '{print ""$5""$6 }'| tr a-z A-Z`
		SSID_SUFFIX="${MAC}"
		;;
	
	esac

	SSID=${SSID_PREFIX}${SSID_SUFFIX}

         cat <<EOF
config wifi-device      mt7628
        option type     mt7628
        option vendor   ralink
        option band     2.4G
        option channel  0
        option auotch   2
        option txpoer   100
        option enable   1

config wifi-iface       ra0
        option device   mt7628
        option ifname   ra0
        option network  lan
        option mode     ap
        option ssid     ${SSID}
        option encryption none
        option hidden   0

config wifi-iface       ra1
        option device   mt7628
        option ifname   ra1
        option network  lan
        option mode     ap
        option ssid     ${SSID}-Guest
        option encryption none
        option enable   0

EOF


}


