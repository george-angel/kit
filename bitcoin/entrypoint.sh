#!/bin/bash

chown -R bitcoin:bitcoin /bitcoin/data || fail "Cannot change ownership of '/bitcoin/data'."

exec gosu bitcoin /usr/bin/bitcoind \
 -datadir=/bitcoin/data \
 -disablewallet \
 -txindex=1 \
 -printtoconsole
