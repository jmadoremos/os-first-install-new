# Sonarr

Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

1. Create the service.

```sh
mkdir -p "${HOME}/.kube/manifests/download-manager"

# Set customizations for the local copy
export METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

export NFS_IP_ADDR="127.0.0.1" # Modify

export NFS_TV_SHOWS_PATH="/volume1/share" # Modify

export SONARR_DOMAIN="sonarr.example.com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/download-manager/sonarr/manifest.yml" > "${HOME}/.kube/manifests/download-manager/sonarr.yaml"

cat "${HOME}/.kube/manifests/download-manager/sonarr.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/download-manager/sonarr.yaml"
```

2. Access the application using the value setup in `SONARR_DOMAIN`.

3. Setup the naming convention and root folder.

    1. Click the `Settings` page.

    2. Click the `Media Management` subpage.

    3. Click the `Show Advanced` button at the top. Additional fields in orange text will appear.

    4. Tick the `Rename Episodes` checkbox as enabled. Several fields will appear.

    5. Set the `Standard Episode Format` to the value below:

        ```
        {Series TitleYear} - S{season:00}E{episode:00} - {Episode CleanTitle} [{Preferred Words }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}
        ```

    6. Set the `Daily Episode Format` to the value below:

        ```
        {Series TitleYear} - {Air-Date} - {Episode CleanTitle} [{Preferred Words }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels]}{[MediaInfo VideoCodec]}{-Release Group}
        ```

    7. Set the `Anime Episode Format` to the value below:

        ```
        {Series TitleYear} - S{season:00}E{episode:00} - {absolute:000} - {Episode CleanTitle} [{Preferred Words }{Quality Full}]{[MediaInfo VideoDynamicRangeType]}[{MediaInfo VideoBitDepth}bit]{[MediaInfo VideoCodec]}[{Mediainfo AudioCodec} { Mediainfo AudioChannels}]{MediaInfo AudioLanguages}{-Release Group}
        ```

    8. Set the `Series Folder Format` to the value below:

        ```
        {Series TitleYear} {imdb-{ImdbId}}
        ```

    9. Set the `Season Folder Format` to the value below:

        ```
        Season {season:00}
        ```

    10. Set the `Multi-Episode Sytle` to `Prefixed Range`.

    11. Tick the `Import Extra Files` checkbox as enabled. A `Import Extra Files` textbox will appear.

    12. Click the `Add Root Folder` button.

    13. Select the `tv` option.

    14. Click the `OK` button. A row will appear with `Path` as `/tv` and `Free Space` as the available space.

4. Setup the quality definitions.

    1. Click the `Settings` page.

    2. Click the `Quality` subpage.

    3. Update the definitions matching the table below:

        | Quality      | Min  | Max  |
        | ------------ | ---- | ---- |
        | Bluray-480p  | 6.3  | 20.8 |
        | WEBRip-720p  | 10   | 33.3 |
        | WEBDL-720p   | 10   | 33.3 |
        | Bluray-720   | 17.1 | 42.7 |
        | WEBRip-1080p | 15   | 53.3 |
        | WEBDL-1080p  | 15   | 53.3 |
        | Bluray-1080p | 50.4 | 400  |

    4. Click the `Save Changes` button at the top.

5. Setup the `Any` quality profile.

    1. Click the `Settings` page.

    2. Click the `Profiles` subpage.

    3. Click the `Any` option.

    4. Tick the `Upgrades Allowed` checkbox as enabled. An `Upgrade Until` will appear.

    5. Set the `Upgrade Until` dropdown to `Bluray-1080p`.

    6. Under the `Qualities` section, make sure only the following are selected.

        - Bluray-1080p

        - WEB 1080p

        - Bluray-720p

        - WEB 720p

        - Bluray-480p

    7. Click the `Save` button.

6. Register the [Deluge](../deluge/README.md) instance.

    1. Click the `Settings` page.

    2. Click the `Download Clients` subpage.

    3. Click the add icon under the `Download Clients` section.

    4. Click the `Deluge` option under the `Torrents` section.

    5. Set the `Name` to `Deluge`.

    6. Set the `Host` to the base domain of the Deluge instance (e.g., deluge.example.com).

    7. Set the `Port` to `443`.

    8. Tick the `Use SSL` checkbox as enabled.

    9. Click the `Test` button to test the connection. There should be a check icon displayed in the button. If none, check steps 7 to 9 for any mistake.

    10. Click the `Save` button.

7. Register the Sonarr instance to [Prowlarr](../prowlarr/README.md).

    1. Click the `Settings` page.

    2. Click the `General` subpage.

    3. Copy the value of `API Key` field.

    4. Setup Sonarr as an application in Prowlarr.

        1. Navigate to the Prowlarr instance in another tab.

        2. Click the `Settings` page.

        3. Click the `Apps` page.

        4. Click the add icon under the `Applications` section.

        5. Select `Sonarr` option.

        6. Set the `Sync Level` to `Full Sync`.

        7. Set the `Prowlarr Server` to the HTTPS URL of the Prowlarr instance (e.g., https://prowlarr.example.com) without the port number.

        8. Set the `Sonarr Server` to the HTTPS URL of this Sonarr instance (e.g., https://sonarr.example.com) without the port number.

        9. Set the `ApiKey` to the value copied from Sonarr.

        10. Click the `Test` button to test the connection. There should be a check icon displayed in the button. If none, check steps 7 to 9 for any mistake.

        11. Click the `Save` button.

* Clean up everything.

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/download-manager/sonarr.yaml"
```
