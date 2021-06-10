#!/bin/sh

set -e
cd "$TARGET_DIR"

#
# Add debugfs to /etc/fstab
#
if ! awk '$1 !~ /^#/ && $2 == "/sys/kernel/debug"' etc/fstab | grep -q .
then
		printf "debugfs\t\t/sys/kernel/debug\tdebugfs\tdefaults\t0\t0\n" \
					>> etc/fstab
fi

# 
#  mount 9p fs to /mnt
#
if ! awk '$1 !~ /^#/ && $2 == "/mnt"' etc/fstab | grep -q .
then
printf "kmod_mount\t\t/mnt\t9p\ttrans=virtio\t0\t0\n" >> etc/fstab
fi

if [ ! -d "lib/modules" ];then
	mkdir -p lib/modules/5.0.0+
fi
