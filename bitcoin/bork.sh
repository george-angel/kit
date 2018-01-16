include docker-deb.bork
include sshd_config.bork
include tor-client-deb.bork

tor_hidden_service_dir="/root/data/tor-hidden-service/"

# format disks
ok apt lvm2
ok apt udev
vgdisplay vg0             || vgcreate vg0 /dev/nbd1 /dev/nbd2
lvdisplay /dev/vg0/data   || lvcreate -l 100%FREE vg0 -n data
fsck -M /dev/vg0/data     || mkfs.ext4 /dev/vg0/data
mountpoint -q /root/data/ || mount /dev/vg0/data /root/data
grep "data" /etc/fstab    || echo "UUID=$(blkid /dev/mapper/vg0-data | sed 's/^.*UUID="\(.*\)" .*$/\1/')     /root/data   auto    rw,user,auto    0    0" >> /etc/fstab

# tor-hidden-service persistent dir
ok directory /root/data/tor-hidden-service
stat -c"%G" ${tor_hidden_service_dir} | grep debian-tor || chgrp debian-tor ${tor_hidden_service_dir}
sudo -u debian-tor test -w ${tor_hidden_service_dir}    || chmod 770 /root && chmod g+w ${tor_hidden_service_dir}

# bitcoin
ok directory /root/data/btc
ok file /etc/systemd/system/bitcoin.service bitcoin.service
if did_install; then
	systemctl enable bitcoin.service
fi
if did_update; then
	systemctl daemon-reload
	systemctl restart bitcoin.service
fi

# tor
ok file /etc/tor/torrc torrc
if did_update; then
	systemctl restart tor.service
fi
