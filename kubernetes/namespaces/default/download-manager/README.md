# Download Manager

Creates a suite of download management services and applications.

> This is deployed to the `default` namespace.

1. Setup the download-manager service.

```sh
mkdir -p "${HOME}/.kube/manifests/default"

# Set customizations for the local copy
export HOST_CIDR="192.168.1.0/24" # Modify

export METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

export TIMEZONE="Asia/Manila" # Modify

export NFS_IP_ADDR="127.0.0.1" # Modify

export NFS_DOWNLOADS_PATH="/volume1/downloads" # Modify

export NFS_DEEMIX_PATH="/volume1/deemix" # Modify

export NFS_MEDIA_PATH="/volume1/media" # Modify

export DELUGE_VPN_DOMAIN="deluge.example.com" # Modify

export DEEMIX_DOMAIN="deemix.example.com" # Modify

export RADARR_1080P_DOMAIN="radarr.example.com" # Modify

export RADARR_4K_DOMAIN="radarr-4k.example.com" # Modify

export SONARR_TV_DOMAIN="sonarr.example.com" # Modify

export SONARR_ANIME_DOMAIN="sonarr-anime.example.com" # Modify

export OVERSEERR_DOMAIN="overseerr.example.com" # Modify

export FLAMESOLVERR_DOMAIN="flaresolverr.example.com" # Modify

export PROWLARR_DOMAIN="prowlarr.example.com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/default/download-manager/manifest.yml" > "${HOME}/.kube/manifests/default/download-manager.yaml"

cat "${HOME}/.kube/manifests/default/download-manager.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/default/download-manager.yaml"
```

* Clean up everything

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/default/download-manager.yaml"
```
