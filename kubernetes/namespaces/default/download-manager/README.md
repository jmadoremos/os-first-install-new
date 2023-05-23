# Download Manager

Creates a suite of download management services and applications.

> This is deployed to the `default` namespace.

1. Setup the download-manager service.

```sh
mkdir -p "${HOME}/.kube/manifests/default"

# Create local copy of the manifest
cat "kubernetes/namespaces/default/download-manager/manifest.yml" | tee "${HOME}/.kube/manifests/default/download-manager.yaml"

HOST_CIDR="192.168.1.0/24" # Modify

METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

TIMEZONE="Asia/Manila" # Modify

NFS_IP_ADDR="127.0.0.1" # Modify

NFS_DOWNLOADS_PATH="/volume1/downloads" # Modify

NFS_DEEMIX_PATH="/volume1/deemix" # Modify

NFS_MEDIA_PATH="/volume1/media" # Modify

DELUGE_VPN_DOMAIN="deluge.example.com" # Modify

DEEMIX_DOMAIN="deemix.example.com" # Modify

RADARR_1080P_DOMAIN="radarr.example.com" # Modify

RADARR_4K_DOMAIN="radarr-4k.example.com" # Modify

SONARR_TV_DOMAIN="sonarr.example.com" # Modify

SONARR_ANIME_DOMAIN="sonarr-anime.example.com" # Modify

OVERSEERR_DOMAIN="overseerr.example.com" # Modify

FLAMESOLVERR_DOMAIN="flaresolverr.example.com" # Modify

PROWLARR_DOMAIN="prowlarr.example.com" # Modify

sed -i "s|\[HOST_CIDR\]|${HOST_CIDR}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[METALLB_PIHOLE_IP_ADDR\]|${METALLB_PIHOLE_IP_ADDR}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[TIMEZONE\]|${TIMEZONE}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[NFS_IP_ADDR\]|${NFS_IP_ADDR}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[NFS_DOWNLOADS_PATH\]|${NFS_DOWNLOADS_PATH}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[NFS_DEEMIX_PATH\]|${NFS_DEEMIX_PATH}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[NFS_MEDIA_PATH\]|${NFS_MEDIA_PATH}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[DELUGE_VPN_DOMAIN\]|${DELUGE_VPN_DOMAIN}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[DEEMIX_DOMAIN\]|${DEEMIX_DOMAIN}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[RADARR_1080P_DOMAIN\]|${RADARR_1080P_DOMAIN}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[RADARR_4K_DOMAIN\]|${RADARR_4K_DOMAIN}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[SONARR_TV_DOMAIN\]|${SONARR_TV_DOMAIN}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[SONARR_ANIME_DOMAIN\]|${SONARR_ANIME_DOMAIN}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[OVERSEERR_DOMAIN\]|${OVERSEERR_DOMAIN}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[FLAMESOLVERR_DOMAIN\]|${FLAMESOLVERR_DOMAIN}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

sed -i "s|\[PROWLARR_DOMAIN\]|${PROWLARR_DOMAIN}|g" "${HOME}/.kube/manifests/default/download-manager.yaml"

cat "${HOME}/.kube/manifests/default/download-manager.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/default/download-manager.yaml"
```

* Clean up everything

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/default/download-manager.yaml"
```
