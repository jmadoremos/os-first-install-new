# External IPs

Update the variables to create the service.

```sh
export ServiceNameLowerCased="sample-service" # Modify

export ServiceIP="192.168.1.100" # Modify

export ServicePort="8080" # Modify

export ServiceDomain="service.example.com" # Modify

cat ./kubernetes/namespaces/default/external-ips/manifest.yml | envsubst | kubectl apply -f --
```

Delete the service created.

```sh
cat ./kubernetes/namespaces/default/external-ips/manifest.yml | envsubst | kubectl delete --ignore-not-found=true -f --
```
