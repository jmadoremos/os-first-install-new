# BitTorrent

This stack creates services to support and manage a BitTorrent client. BitTorrent is a communication protocol for peer-to-peer (P2P) file sharing in  a distributed, decentralized infrastructure.

For more information, refer to [What is BitTorrent?](https://help.bittorrent.com/en/support/solutions/articles/29000039924-what-is-bittorrent-) from BitTorrent.

## Containers

> The Deluge VPN and all *arr container images are created by [binhex](https://github.com/binhex).

* [Deluge VPN](https://github.com/binhex/arch-delugevpn) is a full-featured ​BitTorrent client for Linux, OS X, Unix and Windows. This Docker includes OpenVPN and WireGuard to ensure a secure and private connection to the Internet, including use of iptables to prevent IP leakage when the tunnel is down. It also includes Privoxy to allow unfiltered access to index sites, to use Privoxy please point your application at http://<host ip>:8118.

* [Lidarr](https://github.com/binhex/arch-lidarr) is a music collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new tracks from your favorite artists and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

* [Nginx](https://www.nginx.com) is a simple webserver with php support. This enables the stack to expose the web UIs of the individual applications using a centralized IP address in the host's network.

* [Sonarr](https://github.com/binhex/arch-sonarr) is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

* [Radarr](https://github.com/binhex/arch-radarr) is a fork of Sonarr aims to turn it into something like Couchpotato.

* [Prowlarr](https://hub.docker.com/r/binhex/arch-prowlarr) (custom image) is a indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps. Prowlarr supports both Torrent Trackers and Usenet Indexers. It integrates seamlessly with Sonarr, Radarr, Lidarr, and Readarr offering complete management of your indexers with no per app Indexer setup required (we do it all).

## Environment variables

Configure the following environment variables when creating the stack:

`DIR_DELUGE`

The directory containing deluge-vpn configurations.

_Required_: No

_Default_: `./deluge-vpn`

`DIR_DOWNLOADS`

The directory where dowloading and dowloaded files are stored. This directory should contain `incomplete/` and `completed` directories.

_Required_: Yes

`DIR_LIDARR`

The directory containing lidarr configurations.

_Required_: No

_Default_: `./lidarr`

`DIR_MEDIA`

The directory containing all media files for lidar, radarr and sonarr to reference in their libraries.

_Required_: Yes

`DIR_NGINX`

The directory containing Nginx configuration. This directory should contain the [nginx.conf](./res/nginx.conf) file and a `logs/` directory.

_Required_: Yes

`DIR_PROWLARR`

The directory containing prowlarr configurations.

_Required_: No

_Default_: `./prowlarr`

`DIR_RADARR_FHD`

The directory containing radarr configurations. This instance will manage media up to FHD quality.

_Required_: No

_Default_: `./radarr-fhd`

`DIR_RADARR_UHD`

The directory containing radarr configurations. This instance will manage media up to UHD quality

_Required_: No

_Default_: `./radarr-uhd`

`DIR_SONARR_ANIME`

The directory containing sonarr configurations. This instance will manage Anime media.

_Required_: No

_Default_: `./sonarr-anime`

`DIR_SONARR_TV`

The directory containing sonarr configurations. This instance will manage TV Series media.

_Required_: No

_Default_: `./sonarr-tv`

`LAN_NETWORK`

The local area network CIDR address. This is passed to the VPN client defined in the container variables.

_Required_: No

_Default_: `192.168.1.0/24`

`NAME_SERVERS`

A semi-colon delimited list of name servers. This is passed to the VPN client defined in the container variables.

_Required_: No

_Default_: `192.168.1.1`

`PUID`

A local user's ID. This allows the containers to map their internal users to a user on the host's machine. For more information, refer to [Understanding PUID and PGID](https://docs.linuxserver.io/general/understanding-puid-and-pgid) by LinuxServer.io.

_Required_: No

_Default_: `1000`

`PGID`

A local group's ID. This allows the containers to map their internal users to a user on the host's machine. For more information, refer to [Understanding PUID and PGID](https://docs.linuxserver.io/general/understanding-puid-and-pgid) by LinuxServer.io.

_Required_: No

_Default_: `1000`

`UMASK`

Determines the settings of how permissions are set for newly created files in the containers.

_Required_: No

_Default_: `000`

`VPN_CLIENT`

A VPN client used to secure the connection of the BitTorrent client.

_Required_: No

_Allowed values_: `openvpn`, `wireguard`

_Default_: `wireguard`

`VPN_INPUT_PORTS`

The ports allowed to receive incoming traffic to the VPN client. Do not set unless the implications are well-understood. For more information, refer to [Q24. I would like to be able to route other docker containers through one of my existing VPN containers, how do i do this?](https://github.com/binhex/documentation/blob/master/docker/faq/vpn.md).

_Required_: No

_Default_: _(no value)_

`VPN_INPUT_PORTS`

The ports allowed to send outgoing traffic from the VPN client. Do not set unless the implications are well-understood. For more information, refer to [Q24. I would like to be able to route other docker containers through one of my existing VPN containers, how do i do this?](https://github.com/binhex/documentation/blob/master/docker/faq/vpn.md).

_Required_: No

_Default_: _(no value)_

`VPN_PASS`

The password from the VPN service provider to connect to the VPN client.

_Required_: No unless using a third-party VPN provider (i.e., `VPN_PROV` != `custom`)

_Default_: _(no value)_

`VPN_PROV`

The VPN service provider.

_Required_: No

_Allowed values_: `pia` (Private Internet Access), `airvpn`, `custom` (local)

_Default_: `custom`

`VPN_USER`

The username from the VPN service provider to connect to the VPN client.

_Required_: No unless using a third-party VPN provider (i.e., `VPN_PROV` != `custom`)

_Default_: _(no value)_

## Exposed ports

The `WEBUI_IPADDR` will export a port `80/TCP` to serve a virtual server that will serve `deluge`, `lidarr`, `radarr`, `sonarr` and `prowlarr` web UIs based on the domain used. These domains are configurable in the [nginx.conf](./res/nginx.conf) file.

This stack will not expose the individual ports used by any application apart from port `80/TCP`. However, use the following addresses when configuring these applications:
* `deluge-vpn` address: `http://10.81.12.2:8112/`
* `lidarr` address: `http://10.81.12.3:8686/`
* `prowlarr` address: `http://10.81.12.8:9696/`
* `radarr` (FHD) address: `http://10.81.12.4:7878/`
* `radarr` (UHD) address: `http://10.81.12.5:7878/`
* `sonarr` (Anime) address: `http://10.81.12.6:8989/`
* `sonarr` (TV Series) address: `http://10.81.12.7:8989/`

## Configurations

1. Setup `deluge-vpn` by navigating to its domain as configured in the [nginx.conf](./res/nginx.conf) file.

    1. The default (Old) password is `deluge`. Replace the password with a new value in the `WebUI Password` field of `Interface` page of the `Preferences` dialog box.

    2. In the same `Preferences` dialog box, enable the `Label` plug-in of the `Plug-ins` page.

2. Setup `lidarr`, `radarr` and `sonarr` by navigating to their individual domains as configured in the [nginx.conf](./res/nginx.conf) file.

    1. Connect each of these applications to the `deluge-vpn` by adding a new entry in `Download Clients` section of `Settings > Download Clients` page.

        1. Use the [IP address of deluge-vpn](#exposed-ports) in the `Host` field.
        
        2. Specify the new password in the `Password` field.
        
        3. Update the `Category` field to `lidarr`, `radarr` or `sonarr` based on which application is being updated.

        4. Click the Test button to test the connection. The button should change to a check mark.

        5. Click the Save button.

    2. During the setup, copy the `API Key` in `Settings > General` page to be used when connecting `prowlarr` to these applications.

3. Setup `prowlarr` by navigating to its domain as configured in the [nginx.conf](./res/nginx.conf) file.

    1. Connect `lidarr`, `radarr`, and `sonarr` by adding a new entry in `Applications` section of `Settings > Apps` page.

        1. Use the [domain of prowlarr](#exposed-ports) in the `Prowlarr Server` field.

        2. Use the [domain of each application](#exposed-ports) in the `Lidarr Server`, `Radarr Server` and `Sonarr Server` fields.

        3. Specify the appropriate API key copied from step #2.2 in the `ApiKey` field.

        4. Click the Test button to test the connection. The button should change to a check mark.

        5. Click the Save button.

    2. Connect `deluge-vpn` by adding a new entry in `Download Clients` section of `Settings > Download Clients` page.

        1. Use the [IP address of deluge-vpn](#exposed-ports) in the `Host` field.
        
        2. Specify the new password in the `Password` field.
        
        3. Update the `Category` field to `prowlarr`.

        4. Click the Test button to test the connection. The button should change to a check mark.

        5. Click the Save button.
