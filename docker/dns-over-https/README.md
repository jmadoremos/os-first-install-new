# DNS-over-HTTPS

This stack creates services to enable DNS-over-HTTPS capability on a specific network with DNS sinkhole to reduce advertisements and serve local DNS records.

For more information, refer to [A cartoon intro into DNS-over-HTTPS](https://hacks.mozilla.org/2018/05/a-cartoon-intro-to-dns-over-https/) by Lin Clark.

## Containers

* [DNSCrypt](https://dnscrypt.info) is a protocol that encrypts, authenticates and optionally anonymizes communications between a DNS client and a DNS resolver.

* [Pi-hole](https://pi-hole.net) is a DNS sinkhole that blocks advertisements. It has an informative Web interface that shows stats on all the domains being queried on your network.

* [Prometheus Exporter](https://github.com/eko/pihole-exporter) A Prometheus exporter for Pi-hole.

## Environment variables

Configure the following environment variables when creating the stack:

`DIR_DNSCRYPT`

The directory containing DNSCrypt-proxy configuration. This should contain the [dnscrypt-proxy.toml](./res/dnscrypt-proxy.toml) file.

_Required_: Yes

`HOST_CIDR`

The host network's CIDR notation (e.g., 192.168.0.0/24).

_Required_: Yes

`HOST_GATEWAY`

The host network's gateway address (e.g., 192.168.0.1).

_Required_: Yes

`HOST_IPADDR`

The host's assigned IP address from a DHCP server.

_Required_: Yes

`NETWORK_INTERFACE`

The network interface used.

_Required_: No

_Default_: `eth0`

`PIHOLE_PASS`

The pre-defined Pi-hole web password.

_Required_: Yes

`TIME_ZONE`

The time zone used by Pi-hole to report the time of requests made.

_Required_: No

_Default_: `America/Chicago`

## Exposed ports

The `HOST_IPADDR` will export ports `53/TCP` and `53/UDP` to receive DNS requests from clients, and `8053/TCP` to serve the admin portal.
