# Deluge

Deluge is a full-featured ​BitTorrent client for Linux, OS X, Unix and Windows.

> This includes a Wireguard service running at port 51820.

1. Create the service.

```sh
mkdir -p "${HOME}/.kube/manifests/download-manager"

# Set customizations for the local copy
export METALLB_PIHOLE_IP_ADDR="192.168.3.2" # Modify

export METALLB_WIREGUARD_IP_ADDR="192.168.3.3" # Modify

export NFS_IP_ADDR="127.0.0.1" # Modify

export NFS_DOWNLOADS_PATH="/volume1/share" # Modify

export DELUGE_DOMAIN="deluge.example.com" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/download-manager/deluge/manifest.yml" > "${HOME}/.kube/manifests/download-manager/deluge.yaml"

cat "${HOME}/.kube/manifests/download-manager/deluge.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/download-manager/deluge.yaml"
```

2. Access the application using the value setup in `DELUGE_DOMAIN`. The default password is `deluge`.

3. Setup download folders.

    1. Click the `Preferences` button at the top-most side of the page.

    2. Select the `Downloads` section.

    3. Set `Download to` to `/data/incomplete`.

    4. Set `Move completed to` to `/data/completed`.

    5. Click the `Apply` then the `Close` buttons.

4. Enable plugins.

    1. Click the `Preferences` button at the top-most side of the page.

    2. Select the `Plugins` section.

    3. Tick the `Label` and `Scheduler` plugins as enabled.

    4. Tick additional plugins as necessary.

    5. Click the `Apply` then the `Close` buttons.

* Clean up everything.


```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/download-manager/deluge.yaml"
```
