#!/bin/sh
# Remove old and unnecessary files
rm -rf root.squashfs firmware.bin 
rm -rf squashfs-root/dev/.gitignore
rm -rf squashfs-root/mnt/.gitignore
rm -rf squashfs-root/overlay/.gitignore
rm -rf squashfs-root/proc/.gitignore
rm -rf squashfs-root/root/.gitignore
rm -rf squashfs-root/sys/.gitignore
rm -rf squashfs-root/tmp/.gitignore

mksquashfs squashfs-root root.squashfs -nopad -noappend -root-owned -comp xz -Xpreset 9 -Xe -Xlc 0 -Xlp 2 -Xpb 2 -b 256k -p '/dev d 755 0 0' -p '/dev/console c 600 0 0 5 1' -processors 1

cat openwrt-ramips-mt7628-uImage.bin root.squashfs > firmware.bin

padjffs2 firmware.bin 4 8 16 64 128 256

# Copy back gitignore for git commits
cp -Rf gitignore squashfs-root/dev/.gitignore
cp -Rf gitignore squashfs-root/mnt/.gitignore
cp -Rf gitignore squashfs-root/overlay/.gitignore
cp -Rf gitignore squashfs-root/proc/.gitignore
cp -Rf gitignore squashfs-root/root/.gitignore
cp -Rf gitignore squashfs-root/sys/.gitignore
cp -Rf gitignore squashfs-root/tmp/.gitignore
