### Setup

Export variables on the host, adjusting for your configuration

```
export DISK="/dev/sdb1"
export DISK_MOUNT="${HOME}/data-vol"
export BITCOIN_DATA_DIR="/bitcoind-data-vol"
export IMAGE="quay.io/george_angel/bitcoin:0.15.1-amd64-2"
```

Run the install script on the host:

```
curl -sSL https://raw.githubusercontent.com/george-angel/kit/master/bitcoin/install | bash
```
