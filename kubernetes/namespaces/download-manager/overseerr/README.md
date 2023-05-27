# Overseerr

Overseerr is a request management and media discovery tool built to work with your existing Plex ecosystem. Overseerr helps you find media you want to watch. With inline recommendations and suggestions, you will find yourself deeper and deeper in a rabbit hole of content you never knew you just had to have.

1. Create the service.

```sh
mkdir -p "${HOME}/.kube/manifests/download-manager"

# Set customizations for the local copy
export METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

export OVERSEERR_DOMAIN="overseerr.example.com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/download-manager/overseerr/manifest.yml" > "${HOME}/.kube/manifests/download-manager/overseerr.yaml"

cat "${HOME}/.kube/manifests/download-manager/overseerr.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/download-manager/overseerr.yaml"
```

2. Access the application using the value setup in `OVERSEERR_DOMAIN`.

3. Setup the Overseerr instance.

    1. Sign-in using Plex account or register a local Overseerr account.

    2. Setup the Plex instance.

        1. Either use the `Server` dropdown or use the rest of the fields.

        2. Click the `Save Changes` button. The Plex libraries will be loaded under the `Plex Libraries` section.

        3. Under the `Plex Libraries` section, toggle to `On` the libraries to be synced with Overseerr.

        4. If there are only a few media available in Plex, click the `Start Scan` button now to populate Overseerr with the media available in Plex.

        5. Click the `Continue` button.

    3. If [Radarr](../radarr/README.md), [Radarr (4K)](../radarr-4k/README.md) or both are deployed, setup the Radarr instances.

        1. Click the `Add Radarr Server` button.

        2. Tick the `Default Server` checkbox as enabled.

        3. Tick the `4K Server` checkbox as enabled if the instance is for 4K quality only.

        4. Set the `Server Name` as `Radarr` or `Radarr (4K)` whichever applies.

        5. Set the `Hostname or IP Address` to the base domain of the Radarr instance (e.g., radarr.example.com).

        6. Set the `Port` to `443`.

        7. Tick the `Use SSL` checkbox as enabled.

        8. Set the `ApiKey` to the value copied from Radarr.

        9. Click the `Test` button at the bottom. It should change the `Quality Profile` and `Root Folder` dropdown text from `Test connection to load ...` to `Select ...`. If not, check steps 4 to 8 for any mistake.

        10. Set the `Quality Profile` to `Any`.

        11. Set the `Root Folder` to `/movies`.

        12. Click the `Add Server` button.

        13. Do steps 1 to 12 for the other instance, if any.

    4. If [Sonarr](../sonarr/README.md), [Sonarr (Anime)](../sonarr-anime/README.md) or both are deployed, setup the Sonarr instances.

        1. Click the `Add Sonarr Server` button.

        2. Tick the `Default Server` checkbox as enabled.

        3. Set the `Server Name` as `Sonarr` or `Sonarr (Anime)` whichever applies.

        4. Set the `Hostname or IP Address` to the base domain of the Radarr instance (e.g., radarr.example.com).

        5. Set the `Port` to `443`.

        6. Tick the `Use SSL` checkbox as enabled.

        7. Set the `ApiKey` to the value copied from Radarr.

        8. Click the `Test` button at the bottom. It should change the `Quality Profile`, `Root Folder` and `Language Profile` dropdown text from `Test connection to load ...` to `Select ...`. If not, check steps 4 to 7 for any mistake.

        9. Set the `Quality Profile` to `Any`.

        10. Set the `Root Folder` to `/tv`.

        10. Set the `Language Profile` to `/English`.

        11. Tick the `Season Folders` checkbox as enabled.

        12. Click the `Add Server` button.

        13. Do steps 1 to 12 for the other instance, if any.

    5. Click the `Finish Setup` button.

    6. If the manual scan for Plex was skipped earlier, perform the manual scan to sync the Plex media with Overseerr.

        1. Click the `Settings` page.

        2. Click the `Plex` tab.

        3. Click the `Start Scan` button under the `Manual Library Scan` section. This may take a while to complete.

* Clean up everything.

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/download-manager/overseerr.yaml"
```
