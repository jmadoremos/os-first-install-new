# Radarr

This fork of Sonarr aims to turn it into something like Couchpotato.

1. Create the service.

```sh
mkdir -p "${HOME}/.kube/manifests/download-manager"

# Set customizations for the local copy
export METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

export NFS_IP_ADDR="127.0.0.1" # Modify

export NFS_DOWNLOADS_PATH="/volume1/share" # Modify

export NFS_MOVIES_PATH="/volume1/share" # Modify

export RADARR_DOMAIN="radarr.example.com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/download-manager/radarr/manifest.yml" > "${HOME}/.kube/manifests/download-manager/radarr.yaml"

cat "${HOME}/.kube/manifests/download-manager/radarr.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/download-manager/radarr.yaml"
```

2. Access the application using the value setup in `RADARR_DOMAIN`.

3. Setup the naming convention and root folder.

    1. Click the `Settings` page.

    2. Click the `Media Management` subpage.

    3. Click the `Show Advanced` button at the top. Additional fields in orange text will appear.

    4. Tick the `Rename Movies` checkbox as enabled. A `Standard Movie Format` field will appear.

    5. Set the `Standard Movie Format` to the value below:

        ```
        {Movie CleanTitle} {(Release Year)} {imdb-{ImdbId}} {edition-{Edition Tags}} {[Custom Formats]}{[Quality Full]}{[MediaInfo 3D]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels}][{Mediainfo VideoCodec}]{-Release Group}
        ```

    6. Set the `Movie Folder Format` to the value below:

        ```
        {Movie CleanTitle} ({Release Year})
        ```

    7. Tick the `Import Extra Files` checkbox as enabled. A `Import Extra Files` textbox will appear.

    8. Set the `Import Extra Files` textbox as `srt,nfo`.

    9. Click the `Add Root Folder` button.

    10. Select the `movies` option.

    11. Click the `OK` button. A row will appear with `Path` as `/movies` and `Free Space` as the available space.

    12. Click the `Save Changes` button at the top.

4. Setup quality definitions.

    1. Click the `Settings` page.

    2. Click the `Quality` subpage.

    3. Update the definitions matching the table below:

        | Quality      | Min   | Max |
        | ------------ | ----- | --- |
        | WEBDL-1080p  | 13    | 50  |
        | WEBRip-1080p | 13    | 35  |
        | Bluray-1080p | 13    | 80  |
        | Remux-1080p  | 136.8 | 400 |

    4. Click the `Save Changes` button at the top.

5. Setup the custom formats.

    1. Click the `Settings` page.

    2. Click the `Custom Formats` subpage.

    3. Click the add icon.

    4. Click the `Import` button.

    5. Import one of the the following from [TRaSH Guides](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/):

        - Bad Dual Groups

        - BR-DISK

        - DV (WEBDL)

        - EVO (no WEBDL)

        - FreeLeech

        - IMAX

        - IMAX Enhanced

        - LQ

        - Special Edition

        - Theatrical Cut

        - Upscaled

        - x265 (HD)

    6. Click the `Save` button.

    7. Do steps 5 and 6 for the rest of the custom formats.

6. Setup the `Any` quality profile.

    1. Click the `Settings` page.

    2. Click the `Profiles` subpage.

    3. Click the `Any` option.

    4. Set the `Language` to `Original`.

    5. Set the `Custom Formats` matching the table below:

        | Custom Format   | Score  |
        | --------------- | ------ |
        | IMAX            | 800    |
        | IMAX Enhanced   | 800    |
        | Special Edition | 125    |
        | FreeLeech       | 25     |
        | Theatrical Cut  | 25     |
        | Bad Dual Groups | -10000 |
        | BR-DISK         | -10000 |
        | DV (WEBDL)      | -10000 |
        | EVO (no WEBDL)  | -10000 |
        | LQ              | -10000 |
        | Upscaled        | -10000 |
        | x265 (HD)       | -10000 |

    6. Under the `Qualities` section, make sure only the following are selected.

        - Remux-1080p

        - Bluray-1080p

        - WEB 1080p

    6. Click the `Save` button.

7. Register the [Deluge](../deluge/README.md) instance.

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

8. Register the Radarr instance to [Prowlarr](../prowlarr/README.md).

    1. Click the `Settings` page.

    2. Click the `General` subpage.

    3. Copy the value of `API Key` field.

    4. Setup Radarr as an application in Prowlarr.

        1. Navigate to the Prowlarr instance in another tab.

        2. Click the `Settings` page.

        3. Click the `Apps` page.

        4. Click the add icon under the `Applications` section.

        5. Select `Radarr` option.

        6. Set the `Sync Level` to `Full Sync`.

        7. Set the `Prowlarr Server` to the HTTPS URL of the Prowlarr instance (e.g., https://prowlarr.example.com) without the port number.

        8. Set the `Radarr Server` to the HTTPS URL of this Radarr instance (e.g., https://radarr.example.com) without the port number.

        9. Set the `ApiKey` to the value copied from Radarr.

        10. Click the `Test` button to test the connection. There should be a check icon displayed in the button. If none, check steps 7 to 9 for any mistake.

        11. Click the `Save` button.

* Clean up everything.

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/download-manager/radarr.yaml"
```
