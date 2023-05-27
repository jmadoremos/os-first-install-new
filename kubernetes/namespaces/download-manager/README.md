# Download Manager

1. Create the namespace.

```sh
mkdir -p "${HOME}/.kube/manifests/download-manager"

# Set customizations for the local copy
export TIMEZONE="Asia/Manila" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/download-manager/manifest.yml" > "${HOME}/.kube/manifests/download-manager/manifest.yaml"

cat "${HOME}/.kube/manifests/download-manager/manifest.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/download-manager/manifest.yaml"
```

2. Install required services:

    * [Deluge](deluge/README.md) as downloads manager

    * [Prowlarr](prowlarr/README.md) as indexer

3. Install the desired services:

    * [Radarr](radarr/README.md) as movies manager

    * [Radarr (4K)](radarr-4k/README.md) as movies (4K) manager

    * [Sonarr](sonarr/README.md) as TV shows manager

    * [Sonarr (Anime)](sonarr-anime/README.md) as anime manager

    * [Overseerr](overseerr/README.md) as request manager

* Clean up everything.

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/download-manager/manifest.yaml"
```
