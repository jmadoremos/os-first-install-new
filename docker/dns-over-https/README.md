# DNS-over-HTTPS

This stack creates services to enable DNS-over-HTTPS capability on a specific network with DNS sinkhole to reduce advertisements and serve local DNS records.

For more information, refer to [A cartoon intro into DNS-over-HTTPS](https://hacks.mozilla.org/2018/05/a-cartoon-intro-to-dns-over-https/) by Lin Clark.

## Containers

* [DNSCrypt](https://dnscrypt.info) is a protocol that encrypts, authenticates and optionally anonymizes communications between a DNS client and a DNS resolver.

* [Pi-hole](https://pi-hole.net) is a DNS sinkhole that blocks advertisements. It has an informative Web interface that shows stats on all the domains being queried on your network.

* [Nginx](https://www.nginx.com) is a simple webserver with php support. This enables to expose Pi-hole's web UI with its own IP address in the host's network.

## Environment variables

Configure the following environment variables when creating the stack:

`DIR_DNSCRYPT`

The directory containing DNSCrypt-proxy configuration. This should contain the [dnscrypt-proxy.toml](./res/dnscrypt-proxy.toml) file.

_Required_: Yes

`DIR_NGINX`

The directory containing Nginx configuration. This directory should contain the [nginx.conf](./res/nginx.conf) file and a `logs/` directory.

_Required_: Yes

`DIR_PIHOLE`

The directory containing Pi-hole configurations and data. This directory should contain the `dnsmasq.d/` and `pihole/` directories.

_Required_: No

_Default_: `./pihole`

`HOST_IPADDR`

The host's assigned IP address from a DHCP server.

_Required_: Yes

`WEBUI_IPADDR`

The IP address to be assigned to serve the Pi-hole's web UI.

_Required_: Yes

`WEBUI_MACADDR`

The MAC address to host the Pi-hole's web UI. This can be used to reserve the IP address in a DHCP server.

_Required_: Yes

`WEBUI_MACVLAN`

An existing network using a [macvlan](https://docs.docker.com/network/macvlan/) driver where the Pi-hole's web UI will request for an IP address.

_Required_: Yes

`TIME_ZONE`

The time zone used by Pi-hole to report the time of requests made.

_Required_: No

_Default_: `America/Chicago`

## Exposed ports

The `HOST_IPADDR` will export ports `53/TCP` and `53/UDP` to receive DNS requests from clients.

The `WEBUI_IPADDR` will export a port `80/TCP` to serve Pi-hole's web UI to configure adlists, local DNS records, and other related settings.
