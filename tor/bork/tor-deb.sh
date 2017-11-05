include docker-deb.sh

ok file /etc/systemd/system/tor.service tor.service
if did_install; then
  systemctl enable tor.service
fi

if did_update; then
  systemctl daemon-reload
  systemctl restart tor.service
fi
