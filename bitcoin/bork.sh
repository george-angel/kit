include docker-deb.bork
include sshd_config.bork

ok apt lvm2
ok apt udev
vgdisplay vg0 || vgcreate vg0 /dev/nbd1 /dev/nbd2
lvdisplay /dev/vg0/btcdata || lvcreate -l 100%FREE vg0 -n btcdata
fsck -M /dev/vg0/btcdata || mkfs.ext4 /dev/vg0/btcdata
ok directory /root/btcdata
mountpoint -q /root/btcdata/ || mount /dev/vg0/btcdata /root/btcdata
grep "btcdata" /etc/fstab || echo "UUID=$(blkid /dev/mapper/vg0-btcdata | sed 's/^.*UUID="\(.*\)" .*$/\1/')     /root/btcdata   auto    rw,user,auto    0    0" >> /etc/fstab

ok file /etc/systemd/system/bitcoin.service bitcoin.service
if did_install; then
	systemctl enable bitcoin.service
fi

if did_update; then
	systemctl daemon-reload
	systemctl restart bitcoin.service
fi
