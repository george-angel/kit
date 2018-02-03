### Setup

### variables
```
disk="/dev/sdb1"
disk_mount="${HOME}/data-vol"
bitcoin_data_dir="/bitcoind-data-vol"
image="quay.io/george_angel/bitcoin:0.15.1-amd64-2"
```

### storage

#### mount
```
mountpoint -q ${disk_mount} || sudo mount ${disk} ${disk_mount}
```

#### bitcoin data dir
```
test -d ${disk_mount}${bitcoin_data_dir} || sudo mkdir -p ${disk_mount}${bitcoin_data_dir}
```

### bitcoin

#### Bitcoind service file
```
cat < EOF | sudo tee /etc/systemd/system/bitcoind.service
# /etc/systemd/system/bitcoind.service
[Unit]
Description=Bitcoin node
After=docker.service
Requires=docker.service

[Service]
Restart=on-failure
ExecStart=/bin/sh -c '\
 docker run --name=%p --rm \
 -v ${disk_mount}${bitcoin_data_dir}:/bitcoin/data:rw \
 -p 8333:8333 \
 -p 9735:9735 \
 ${image}'
ExecStop=/bin/sh -c 'docker stop -t 3 %p'

[Install]
WantedBy=multi-user.target
EOF
```

On creation: `sudo systemctl enable bitcoind.service && sudo systemctl start bitcoind`
On update: `sudo systemctl daemon-reload && sudo systemctl restart bitcoind.service`

#### bitcoin-cli
```
cat < EOF | sudo tee /usr/local/bin/bitcoin-cli
#!/bin/bash
docker run --rm --network container:bitcoind -v ${disk_mount}${bitcoin_data_dir}:/bitcoin/data:rw ${image} bitcoin-cli "\$@"
EOF
sudo chmod +x /usr/local/bin/bitcoin-cli
```
