#!/bin/sh

sed 's#%%NETWORK_NAME%%#'"$NETWORK_NAME"'#' -i netsyslog.conf

/entrypoint.sh