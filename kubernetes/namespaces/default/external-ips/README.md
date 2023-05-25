# External IPs

1. Create `external` namespace to store all external services.

```sh
kubectl create namespace external
```

2. Update the variables to create the service.

```sh
export SERVICE_NAME_LOWERCASED="sample-service" # Modify

export SERVICE_IP_ADDR="192.168.1.100" # Modify

export SERVICE_PORT="8080" # Modify

export SERVICE_DOMAIN="service.example.com" # Modify

export SERVICE_PATH_PREFIX="/" # Modify

cat ./kubernetes/namespaces/default/external-ips/manifest.yml | envsubst | kubectl apply -f -
```

3. Check the status of the service.

```sh
watch kubectl get --namespace external svc,ingressroute
```

* Delete the service created.

```sh
export SERVICE_NAME_LOWERCASED="sample-service" # Modify

cat ./kubernetes/namespaces/default/external-ips/manifest.yml | envsubst | kubectl delete --ignore-not-found=true -f -
```
