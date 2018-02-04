### Setup

Export variables on the host, adjusting for your configuration

```
export DISK_MOUNT="${HOME}/data-vol"
export BITCOIN_DATA_DIR="/bitcoind-data-vol"
export CLIGHTNING_DATA_DIR="/clightning-data-vol"
export IMAGE="cdecker/lightningd:master"
```

Run the install script on the host:

```
curl -sSL https://raw.githubusercontent.com/george-angel/kit/master/clightning/install | bash
```
