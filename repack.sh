#!/bin/sh
rm -rf root.squashfs firmware.bin
mksquashfs squashfs-root root.squashfs -nopad -noappend -root-owned -comp xz -Xpreset 9 -Xe -Xlc 0 -Xlp 2 -Xpb 2 -b 256k -p '/dev d 755 0 0' -p '/dev/console c 600 0 0 5 1' -processors 1
cat WAVLINK_529B3EN_UIMAGE_KERNEL.bin root.squashfs > firmware.bin
padjffs2 firmware.bin 4 8 16 64 128 256
