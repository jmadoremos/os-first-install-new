# Prowlarr

Prowlarr is a indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps. Prowlarr supports both Torrent Trackers and Usenet Indexers. It integrates seamlessly with Sonarr, Radarr, Lidarr, and Readarr offering complete management of your indexers with no per app Indexer setup required (we do it all).

> This includes a FlareSolverr service running at port 8191.

1. Create the service.

```sh
mkdir -p "${HOME}/.kube/manifests/download-manager"

# Set customizations for the local copy
export METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

export TIMEZONE="Asia/Manila" # Modify

export PROWLARR_DOMAIN="prowlarr.example.com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/download-manager/prowlarr/manifest.yml" > "${HOME}/.kube/manifests/download-manager/prowlarr.yaml"

cat "${HOME}/.kube/manifests/download-manager/prowlarr.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/download-manager/prowlarr.yaml"
```

2. Access the application using the value setup in `PROWLARR_DOMAIN`.

3. Setup an authentication method.

4. Setup the FlareSolverr as a proxy.

    1. Click the `Settings` page.

    2. Click the `Indexer` subpage.

    3. Click the add icon under the `Indexer Proxies` section.

    4. Select the `FlareSolverr` option.

    5. Set the `Name` as `FlareSolverr`.

    6. Set the `Tags` as `flaresolverr`.

    7. Click the `Test` button to test the connection. There should be a check icon displayed in the button.

    8. Click the `Save` button.

5. Setup the indexers.

    1. Click the `Indexers` page.

    2. Click the `Add Indexer` button at the top.

    3. Set the `Protocol` to `torrent`.

    4. Set the `Privacy` to `Public`.

    5. Setup desired indexers.

        1. Click a desired indexer from the result.

        2. Set the `Base URL` to a preferred URL.

        3. Set additional configuration as necessary.

        4. Click the `Test` button to test the connection. There should be a check icon displayed in the button. If there is a problem, select other base URL value.

        5. Click the `Save` button.

        6. Do the same steps for additional indexers.

    6. Click the `Close` button.

* Clean up everything.

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/download-manager/prowlarr.yaml"
```
