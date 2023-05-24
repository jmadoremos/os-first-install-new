# Quant UX

[Quant UX](https://github.com/KlausSchaefers/quant-ux) is a research, usability and prototyping tool to quickly test your designs and get data driven insights. This repo contains the front end.

> This is deployed to the `default` namespace.

```sh
mkdir -p "${HOME}/.kube/manifests/default"

# Create local copy of the manifest
cat "kubernetes/namespaces/default/quant-ux/manifest.yml" | tee "${HOME}/.kube/manifests/default/quant-ux.yaml"

# Apply customizations to the local copy
QUX_DOMAIN="qux.example.com" # Modify

QUX_JWT_PASSWORD="THIS_IS_A_SECURE_PASSWORD" # Modify

SMTP_HOST="mail.example.com" # Modify

SMTP_USER="username" # Modify

SMTP_PASSWORD="password" # Modify

TIMEZONE="Asia/Manila" # Modify

sed -i "s|\[QUX_DOMAIN\]|${QUX_DOMAIN}|g" "${HOME}/.kube/manifests/default/quant-ux.yaml"

sed -i "s|\[QUX_JWT_PASSWORD\]|${QUX_JWT_PASSWORD}|g" "${HOME}/.kube/manifests/default/quant-ux.yaml"

sed -i "s|\[SMTP_HOST\]|${SMTP_HOST}|g" "${HOME}/.kube/manifests/default/quant-ux.yaml"

sed -i "s|\[SMTP_USER\]|${SMTP_USER}|g" "${HOME}/.kube/manifests/default/quant-ux.yaml"

sed -i "s|\[SMTP_PASSWORD\]|${SMTP_PASSWORD}|g" "${HOME}/.kube/manifests/default/quant-ux.yaml"

sed -i "s|\[TIMEZONE\]|${TIMEZONE}|g" "${HOME}/.kube/manifests/default/quant-ux.yaml"

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
