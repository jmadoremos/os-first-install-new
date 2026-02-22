# DNS-over-HTTPS

This stack creates services to enable DNS-over-HTTPS capability on a specific network with DNS sinkhole to reduce advertisements and serve local DNS records.

For more information, refer to [A cartoon intro into DNS-over-HTTPS](https://hacks.mozilla.org/2018/05/a-cartoon-intro-to-dns-over-https/) by Lin Clark.

## Containers

* [DNSCrypt](https://dnscrypt.info) is a protocol that encrypts, authenticates and optionally anonymizes communications between a DNS client and a DNS resolver.

* [Pi-hole](https://pi-hole.net) is a DNS sinkhole that blocks advertisements. It has an informative Web interface that shows stats on all the domains being queried on your network.

## Environment variables

Configure the following environment variables when creating the stack:

### DIR_DNSCRYPT

Used by DNSCrypt Proxy. The directory containing its configuration. This path should contain the [dnscrypt-proxy.toml](./res/dnscrypt-proxy.toml) file.

**Required**: No

**Default**: `./dnscrypt`

### DIR_PIHOLE

Used by Pi-hole. The directory containing its configuration. This path should contain a **dnsmasq.d** folder.

**Required**: No

**Default**: `./pihole`

### HOST_IPADDR

The host's assigned IP address from a DHCP server.

**Required**: Yes

### NETWORK_INTERFACE

The network interface used.

**Required**: No

**Default**: `eth0`

### PIHOLE_PASS

The pre-defined Pi-hole web password.

**Required**: Yes

### TZ

Used by Pi-hole. The time zone to report the time of requests made.

**Required**: No

**Default**: `America/Chicago`

## Exposed ports

The `HOST_IPADDR` will export ports `53/TCP` and `53/UDP` to receive DNS requests from clients, and `8053/TCP` to serve the admin portal.
