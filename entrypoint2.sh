#!/bin/bash

sed 's#%%NETWORK_NAME%%#'"$NETWORK_NAME"'#g' -i /etc/google-fluentd/config.d/netsyslog.conf

exec "/entrypoint.sh" "$@"
