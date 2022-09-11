# Docker

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

Categories:

* Artificial Intelligence

  * [Jupyter Notebook](#jupyter-notebook)

* Multimedia Services

  * [BitTorrent](#bittorrent)

  * [Jellyfin](#jellyfin)

  * [Plex Media Server](#plex-media-server)

* Security

  * [DNS-over-HTTPS](#dns-over-https-dnscrypt--pi-hole--nginx)

  * [Recursive DNS](#recursive-dns-unbound--pi-hole--nginx)

  * [Wireguard](#wireguard)

## Containers

> The containers below assume that Network Shares are mounted to `/export` directory, and local IP address of the server running docker is `127.0.0.1`.

### BitTorrent

This stack creates services to support and manage a BitTorrent client. BitTorrent is a communication protocol for peer-to-peer (P2P) file sharing in  a distributed, decentralized infrastructure.

```sh
docker compose up --detach "docker/bittorrent/docker-compose.yml" 
```

### Jellyfin

[Jellyfin](https://jellyfin.org) is the volunteer-built media solution that puts you in control of your media. Stream to any device from your own server, with no strings attached.

```sh
docker compose up --detach "docker/jellyfin/docker-compose.yml"
```

### Jupyter Notebook

The [Jupyter Notebook](https://jupyter.org) is the original web application for creating and sharing computational documents. It offers a simple, streamlined, document-centric experience.

```sh
docker compose up --detach "docker/jupyter-notebook/docker-compose.yml"
```

### DNS-over-HTTPS (DNSCrypt + Pi-hole + Nginx)

> Install only one of DNS-over-HTTPS and Recursive DNS in the same host IP address.

This stack creates services to enable DNS-over-HTTPS capability on a specific network with DNS sinkhole to reduce advertisements and serve local DNS records.

```sh
docker compose up --detach "docker/dns-over-https/docker-compose.yml"
```

### Recursive DNS (Unbound + Pi-hole + Nginx)

> Install only one of DNS-over-HTTPS and Recursive DNS in the same host IP address.

This stack creates services to enable recursive DNS capability on a specific network with DNS sinkhole to reduce advertisements and serve local DNS records.

```sh
docker compose up --detach "docker/recursive-dns/docker-compose.yml"
```

### Plex Media Server

[Plex](https://www.plex.tv) gives you the power to add, access and share all the entertainment that matters to you, on almost any device.

```sh
docker compose up --detach "docker/plex/docker-compose.yml"
```

### Wireguard

[WireGuard®](https://www.wireguard.com/) is an extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography.

```sh
docker compose up --detach "docker/wireguard/docker-compose.yml"
```
