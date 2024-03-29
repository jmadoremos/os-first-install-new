# Quant UX

[Quant UX](https://github.com/KlausSchaefers/quant-ux) is a research, usability and prototyping tool to quickly test your designs and get data driven insights. This repo contains the front end.

> This is deployed to the `default` namespace.

```sh
mkdir -p "${HOME}/.kube/manifests/default"

# Set customizations for the local copy
export QUX_DOMAIN="qux.example.com" # Modify

export QUX_JWT_PASSWORD="THIS_IS_A_SECURE_PASSWORD" # Modify

export QUX_SMTP_HOST="mail.example.com" # Modify

export QUX_SMTP_USER="username" # Modify

export QUX_SMTP_PASS="password" # Modify

export TIMEZONE="Asia/Manila" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/default/quant-ux/manifest.yml" > "${HOME}/.kube/manifests/default/quant-ux.yaml"

cat "${HOME}/.kube/manifests/default/quant-ux.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/default/quant-ux.yaml"

# Check status
kubectl get all
```

Remove the deployment.

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/default/quant-ux.yaml"
```
