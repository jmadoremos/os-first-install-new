# Docker

Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

Categories:

* Artificial Intelligence

  * [Jupyter Notebook](#jupyter-notebook)

* Multimedia Services

  * [Deluge VPN](#deluge-vpn)

  * [Jellyfin](#jellyfin)

  * [Plex Media Server](#plex-media-server)

* Security

  * [DNS-over-HTTPS](#dns-over-https-dnscrypt--pi-hole--nginx)

  * [Recursive DNS](#recursive-dns-unbound--pi-hole--nginx)

  * [Wireguard](#wireguard)

## Containers

> The containers below assume that Network Shares are mounted to `/export` directory, and local IP address of the server running docker is `127.0.0.1`.

### Deluge VPN

[Deluge VPN](https://github.com/binhex/arch-delugevpn) (custom image) is a full-featured ​BitTorrent client for Linux, OS X, Unix and Windows.

This Docker includes OpenVPN and WireGuard to ensure a secure and private connection to the Internet, including use of iptables to prevent IP leakage when the tunnel is down. It also includes Privoxy to allow unfiltered access to index sites, to use Privoxy please point your application at http://<host ip>:8118.

[Lidarr](https://github.com/binhex/arch-lidarr) (custom image) is a music collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new tracks from your favorite artists and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

[Sonarr](https://github.com/binhex/arch-sonarr) (custom image) is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

[Radarr](https://github.com/binhex/arch-radarr) (custom image) is a fork of Sonarr aims to turn it into something like Couchpotato.

[Prowlarr](https://hub.docker.com/r/binhex/arch-prowlarr) (custom image) is a indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps. Prowlarr supports both Torrent Trackers and Usenet Indexers. It integrates seamlessly with Sonarr, Radarr, Lidarr, and Readarr offering complete management of your indexers with no per app Indexer setup required (we do it all).

```sh
docker compose up --detach "docker/deluge-vpn/docker-compose.yml" 
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
