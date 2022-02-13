# Docker

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

Categories:

* Artificial Intelligence

  * [Jupyter Notebook](#jupyter-notebook)

* Multimedia Services

  * [Jellyfin](#jellyfin)

  * [Plex Media Server](#plex-media-server)

* Security

  * [Pihole + DNSCrypt](#pi-hole--dnscrypt-dns-on-https)

  * [Pihole + Unbound](#pi-hole--unbound-recursive-dns)

## Containers

> The containers below assume that Network Shares are mounted to `/mnt` directory.

### Jellyfin

[Jellyfin](https://jellyfin.org) is the volunteer-built media solution that puts you in control of your media. Stream to any device from your own server, with no strings attached.

```sh
docker-compose "docker/jellyfin/docker-compose.yml"
```

### Jupyter Notebook

The [Jupyter Notebook](https://jupyter.org) is the original web application for creating and sharing computational documents. It offers a simple, streamlined, document-centric experience.

```sh
docker-compose "docker/jupyter-notebook/docker-compose.yml"
```

### Pi-hole + DNSCrypt (DNS-on-HTTPS)

> Install only one of pihole-dnscrypt and pihole-unbound.

In addition to blocking advertisements, [Pi-hole](https://pi-hole.net) has an informative Web interface that shows stats on all the domains being queried on your network.

[DNSCrypt](https://dnscrypt.info) is a protocol that encrypts, authenticates and optionally anonymizes communications between a DNS client and a DNS resolver.

```sh
docker-compose "docker/pihole-dnscrypt/docker-compose.yml"
```

### Pi-hole + Unbound (Recursive DNS)

> Install only one of pihole-dnscrypt and pihole-unbound.

In addition to blocking advertisements, [Pi-hole](https://pi-hole.net) has an informative Web interface that shows stats on all the domains being queried on your network.

[Unbound](https://www.nlnetlabs.nl/projects/unbound/about) is a validating, recursive, caching DNS resolver. It is designed to be fast and lean and incorporates modern features based on open standards.

```sh
docker-compose "docker/pihole-unbound/docker-compose.yml"
```

### Plex Media Server

[Plex](https://www.plex.tv) gives you the power to add, access and share all the entertainment that matters to you, on almost any device.

```sh
docker-compose "docker/plex/docker-compose.yml"
```
