include docker-deb.sh

ok directory /data
ok file /etc/systemd/system/bitcoin.service bitcoin.service
if did_install; then
  systemctl enable bitcoin.service
fi

if did_update; then
  systemctl daemon-reload
  systemctl restart bitcoin.service
fi
