#!/bin/sh
# Registers the SYR Connect hostnames at the sni-router and renews the
# registration until the container stops. The router publishes host ports
# 80 and 443 and forwards connections for these hostnames to this container.
# default=true keeps devices that send no server name or Host header here.

hosts='"syrconnect.de","maintenance.syrconnect.de","firmware.syrconnect.de","syrconnect.consoft.de","connect.saocal.pl"'
body="{\"hosts\":[$hosts],\"http_port\":80,\"https_port\":443,\"default\":true}"

if [ -n "${SNI_ROUTER_URL:-}" ]; then
	(
		while true; do
			wget -q -O /dev/null -T 10 --header 'Content-Type: application/json' --post-data "$body" "$SNI_ROUTER_URL/routes" \
				|| echo "registration at $SNI_ROUTER_URL failed" >&2
			sleep 30
		done
	) &
fi

exec node syrlex2mqtt.js
