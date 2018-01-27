include sshd_config.bork

#disk="/dev/sda1"
#disk_mount="/root/data-vol"
#bitcoin_data_dir="/bitcoin-data"
#
## storage
#fsck -M ${disk}             || mkfs.ext4 ${disk}
#mountpoint -q ${disk_mount} || mount ${disk} ${disk_mount}
#grep "data-vol" /etc/fstab \
#  || echo "UUID=$(blkid ${disk} | sed 's/^.*UUID="\(.*\)" .*$/\1/')     ${disk_mount}   auto    rw,user,auto    0    0" >> /etc/fstab

# bitcoin
#ok directory ${disk_mount}${bitcoin_data_dir}
ok file /etc/systemd/system/bitcoin.service bitcoin.service
if did_install; then
	systemctl enable bitcoin.service
fi
if did_update; then
	systemctl daemon-reload
	systemctl restart bitcoin.service
fi
