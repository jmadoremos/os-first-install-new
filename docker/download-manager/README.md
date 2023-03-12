# Download Manager

This stack creates services to support and manage a BitTorrent and a Usenet clients. BitTorrent is a communication protocol for peer-to-peer (P2P) file sharing in  a distributed, decentralized infrastructure. Usenet is an early non-centralized computer network for the discussion of particular topics and the sharing of files via newsgroups.

For more information, refer to [What is BitTorrent?](https://help.bittorrent.com/en/support/solutions/articles/29000039924-what-is-bittorrent-) from BitTorrent and [Usenet](https://en.wikipedia.org/wiki/Usenet) from Wikipedia.

## Containers

> The Deluge VPN and all *arr container images are created by [binhex](https://github.com/binhex).

* [Deluge VPN](https://github.com/binhex/arch-delugevpn) is a full-featured ​BitTorrent client for Linux, OS X, Unix and Windows. This Docker includes OpenVPN and WireGuard to ensure a secure and private connection to the Internet, including use of iptables to prevent IP leakage when the tunnel is down. It also includes Privoxy to allow unfiltered access to index sites, to use Privoxy please point your application at http://<host ip>:8118.

* [Deemix](https://deemix.app/) is a barebone deezer downloader library built from the ashes of Deezloader Remix.

* [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr) is a proxy server to bypass Cloudflare and DDoS-GUARD protection.

* [Lidarr](https://github.com/binhex/arch-lidarr) is a music collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new tracks from your favorite artists and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

* [Prometheus Exporter](https://github.com/tobbez/deluge_exporter) A Prometheus exporter for Deluge.

* [Prowlarr](https://hub.docker.com/r/binhex/arch-prowlarr) (custom image) is a indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps. Prowlarr supports both Torrent Trackers and Usenet Indexers. It integrates seamlessly with Sonarr, Radarr, Lidarr, and Readarr offering complete management of your indexers with no per app Indexer setup required (we do it all).

* [Radarr](https://github.com/binhex/arch-radarr) is a fork of Sonarr aims to turn it into something like Couchpotato.

* [SABnzbd VPN](https://github.com/binhex/arch-sabnzbdvpn) is an Open Source Binary Newsreader written in Python.

* [Sonarr](https://github.com/binhex/arch-sonarr) is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

## Environment variables

Configure the following environment variables when creating the stack:

`CAPTCHA_SOLVER`

Used by [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr). Captcha solving method. It is used when a captcha is encountered.

_Required_: No

_Default_: `none`

`DELUGE_PASS`

The password to be set or already set for Deluge web client.

_Required_: Yes

`DIR_DEEMIX`

The directory containing deemix configurations.

_Required_: No

_Default_: `./deemix`

`DIR_DELUGE`

The directory containing deluge-vpn configurations.

_Required_: No

_Default_: `./deluge-vpn`

`DIR_DOWNLOADS_ARR`

The directory where dowloading and dowloaded movies and TV series are stored. This directory should contain `incomplete/` and `completed` directories.

_Required_: Yes

`DIR_DOWNLOADS_DEEMIX`

The directory where dowloading and dowloaded music from Deemix are stored.

_Required_: Yes

`DIR_LIDARR`

The directory containing lidarr configurations.

_Required_: No

_Default_: `./lidarr`

`DIR_MEDIA`

The directory containing all media files for lidar, radarr and sonarr to reference in their libraries.

_Required_: Yes

`DIR_OVERSEERR`

The directory containing overseerr configurations.

_Required_: No

_Default_: `./overseerr`

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

`DIR_SABNZBD`

The directory containing SABnzbd-vpn configurations.

_Required_: No

_Default_: `./sabnzbd-vpn`

`DIR_SONARR_ANIME`

The directory containing sonarr configurations. This instance will manage Anime media.

_Required_: No

_Default_: `./sonarr-anime`

`DIR_SONARR_TV`

The directory containing sonarr configurations. This instance will manage TV Series media.

_Required_: No

_Default_: `./sonarr-tv`

`HOST_CIDR`

The local area network CIDR address. This is passed to the VPN client defined in the container variables.

_Required_: No

_Default_: `192.168.1.0/24`

`LOG_LEVEL`

Used by [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr). Verbosity of the logging. Use `debug` for more information.

_Required_: No

_Default_: `info`

`LOG_HTML`

Used by [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr). Only for debugging. If `true`, all HTML that passes through the proxy will be logged to the console in `debug` level.

_Required_: No

_Default_: `false`

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

`SABNZBD_API_KEY`

Comma seperated list of API keys for SABnzbd. Positionally each API key must be for the same server as in the equivilent position of the SABNZBD_BASEURLS.

_Required_: Yes

`TZ`

Used by [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr). Timezone used in the logs and the web browser.

_Required_: No

_Default_: `Europe/London`

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

This stack will not expose the individual ports used by any application apart from port `80/TCP`. However, use the following addresses when configuring these applications:
* `deluge-vpn` address: `http://10.81.12.2:8112/`
* `deemix` address: `http://10.81.12.10:6595/`
* `flaresolverr` address: `http://10.81.12.12:8191/`
* `lidarr` address: `http://10.81.12.3:8686/`
* `overseerr` address: `http://10.81.12.11:5055/`
* `prometheus` (Deluge) address: `http://10.81.12.9:9354/`
* `prowlarr` address: `http://10.81.12.8:9696/`
* `radarr` (FHD) address: `http://10.81.12.4:7878/`
* `radarr` (UHD) address: `http://10.81.12.5:7878/`
* `sabnzbd-vpn` address: `http://10.81.12.13:8080/`
* `sonarr` (Anime) address: `http://10.81.12.6:8989/`
* `sonarr` (TV Series) address: `http://10.81.12.7:8989/`

## Configurations

1. Setup `deluge-vpn` by navigating to its domain.

    1. The default (Old) password is `deluge`. Replace the password with a new value in the `WebUI Password` field of `Interface` page of the `Preferences` dialog box.

    2. In the same `Preferences` dialog box, enable the `Label` plug-in of the `Plug-ins` page.

2. Setup `sabnzdb-vpn`.

    1. Before starting the container, do the following:
    
        1. Create a `/config/wg0.conf` file that contains the WireGuard configuration.

        2. Update `/config/sabnzbd.ini` file,
        
            * Update `host_whitelist` to add an entry matching the URL used to reverse proxy to the container web UI, if any.

                > This property is a comma-separated (with spaces) values of base URLs (i.e., without http:// or https://, and port number).

            * Set `download_dir` to `/data/incomplete`

            * Set `complete_dir` to `/data/completed`

            * Copy the value of `api_key` to be used for `sabnzbd-monitor` container. This value is auto generated.

    3. After starting the container, wait for about 5 minutes before navigating to its domain.

    4. Configure SABnzbd by setting language and defining primary usenet host.

    5. In SABnzbd configuration page, add `prowlarr` as a category under `Category` tab.

3. Setup `deemix` by navigating to its domain.

    1. Go to the `Settings` page, and login to `Deezer`.

4. Setup `lidarr`, `radarr` and `sonarr` by navigating to their individual domains.

    1. Connect each of these applications to the `deluge-vpn` by adding a new entry in `Download Clients` section of `Settings > Download Clients` page.

        1. Use the [IP address of deluge-vpn](#exposed-ports) in the `Host` field.
        
        2. Specify the new password in the `Password` field.
        
        3. Update the `Category` field to `lidarr`, `radarr` or `sonarr` based on which application is being updated.

        4. Click the Test button to test the connection. The button should change to a check mark.

        5. Click the Save button.

    2. During the setup, copy the `API Key` in `Settings > General` page to be used when connecting `prowlarr` to these applications.

5. Setup `prowlarr` by navigating to its domain.

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

    3. Connect `sabnzbd-vpn` by adding a new entry in `Download Clients` section of `Settings > Download Clients` page.

        1. Use the [IP address of deluge-vpn](#exposed-ports) in the `Host` field.
        
        2. Specify the API key in the `API Key` field using the value retrieved from `sabnzbd.ini` when setting up the configuration.

        3. Click the Test button to test the connection. The button should change to a check mark.

        4. Click the Save button.

    4. Connect `flaresolverr` by adding a new indexer proxy in `Indexer Proxies` section of `Settings > Indexers` page.

        1. Use the [IP address of deluge-vpn](#exposed-ports) in the `Host` field.

        2. Specify any name.

        3. Specify `flaresolverr` in the `Tags` field. This will ensure that all indexers that use the `flaresolverr` tag will proxy through FlareSolverr.

        4. Click the Save button.

    5. Add Indexers by clicking the `+ Add Indexer` button in the `Indexers` page.

        > For indexers with `FlareSolverr` section in the `Edit Indexer` page, add the `flaresolverr` in the `Tags` field. 

6. Setup `overseerr` by navigating to its domain.

    1. Login to Plex.

    2. Connect to a Plex Media Server and select the libraries to sync.

    3. Connect `radarr` and `sonarr`.

        1. For `radarr`,

            1. Click `+ Add Radarr Server` button.

            2. Specify the following values:

                * `Default Server`: _Yes_.

                * `4K Server`:  _No_ if FHD, _Yes_ if UHD.

                * `Server Name`: Any name desired that differentiates FHD and UHD versions.

                * `Hostname or IP Address`: Refer to [domain of each application](#exposed-ports) for the domain but use only the IP Address.

                * `Port`: _7878_.

                * `Use SSL`: _No_.

                * `API Key`: Specify the appropriate API key copied from step #2.2 in the `ApiKey` field.

                * `Quality Profile`: Click the `Test` button first to load options, then select _Any_ as value.

                * `Root Folder`: Options should have loaded after clicking the `Test` button, then select desired value.

                * `Minimum Availability`: _Released_.

                * `Tags`: Don't select any value.

                * `External URL`: _Blank_.

                * `Enable Scan`: _No_.

                * `Enable Automatic Search`: _Yes_.

            3. Click `Add Server` button.

            4. Repeat for the other Radarr version.

        2. For `sonarr`,

            1. Click `+ Add Sonarr Server` button.

            2. Specify the following values:

                * `Default Server`: _Yes_.

                * `4K Server`: _No_.

                * `Server Name`: Any name desired that differentiates Anime and TV Series versions.

                * `Hostname or IP Address`: Refer to [domain of each application](#exposed-ports) for the domain but use only the IP Address.

                * `Port`: _8989_.

                * `Use SSL`: _No_.

                * `API Key`: Specify the appropriate API key copied from step #2.2 in the `ApiKey` field.

                * `Quality Profile`: Click the `Test` button first to load options, then select _Any_ as value.

                * `Root Folder`: Options should have loaded after clicking the `Test` button, then select desired value.

                * `Language Profile`: _English_ if TV Series, _Sub/Dub_ if Anime.

                * `Tags`: Don't select any value.

                * `Anime Quality Profile`: Don't select any value if TV Series, select _Any_ if Anime. 

                * `Anime Root Folder`: Don't select any value if TV Series, select desired value if Anime.

                * `Anime Language Profile`: Don't select any value.

                * `Anime Tags`: Don't select any value if TV Series, _Sub/Dub_ if Anime.

                * `Season Folders`: _Yes_.

                * `External URL`: _Blank_.

                * `Enable Scan`: _No_.

                * `Enable Automatic Search`: _Yes_.

            3. Click `Add Server` button.

            4. Repeat for the other Sonarr version.

    4. Click `Finish Setup` to continue.
