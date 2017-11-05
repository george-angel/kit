#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

_torrc="$(mktemp -t torrc.XXXXXX)"
_template="${TOR_CONFIG_TEMPLATE:-relay}"
cat "/etc/tor/${_template}-torrc" | envsubst > "${_torrc}" && \
 chown tor:root "${_torrc}" && \
 su-exec tor tor -f "${_torrc}" "$@"
