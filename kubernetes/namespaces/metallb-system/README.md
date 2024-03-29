# MetalLB

MetalLB is a load-balancer implementation for bare metal Kubernetes clusters, using standard routing protocols.

1. Apply the MetalLB manifest.

```sh
mkdir -p "${HOME}/.kube/manifests/metallb-system"

METALLB_VERSION="v0.13.12" # Modify

curl "https://raw.githubusercontent.com/metallb/metallb/${METALLB_VERSION}/config/manifests/metallb-native.yaml" --output "${HOME}/.kube/manifests/metallb-system/metallb-native.yaml"

kubectl apply -f "${HOME}/.kube/manifests/metallb-system/metallb-native.yaml"

# Check status
watch kubectl get --namespace metallb-system pods -o wide
```

2. Apply the MetalLB pool.

```sh
# Set customizations for the local copy
export METALLB_DEDICATED_CIDR="192.168.2.0/24" # Modify

export METALLB_CORE_CIDR="192.168.3.0/29" # Modify

# Create local copy of the manifest
envsubst < "kubernetes/namespaces/metallb-system/ip-address-pools.yml" > "${HOME}/.kube/manifests/metallb-system/ip-address-pools.yaml"

cat "${HOME}/.kube/manifests/metallb-system/ip-address-pools.yaml"

# Apply the manifest using the local copy
kubectl apply -f "${HOME}/.kube/manifests/metallb-system/ip-address-pools.yaml"

# Check status
watch kubectl get --namespace metallb-system IPAddressPool -o wide
```

3. Configure the network router with static route from the master nodes to the values set in `DEDICATED_IP_CIDR` and `CORE_IP_CIDR` using next hop type.

4. Test a web deployment.

```sh
kubectl create deploy nginx --image=nginx

kubectl expose deploy nginx --port=80 --target-port=80 --type=LoadBalancer

kubectl get all

# Clean up
kubectl delete --ignore-not-found=true deploy nginx

kubectl delete --ignore-not-found=true svc nginx

kubectl get all
```

* Clean up everything

> Always drop both `ip-address-pools.yml` and `metallb-native.yaml` to reconfigure MetalLB.

```sh
kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/metallb-system/ip-address-pools.yaml"

kubectl delete --ignore-not-found=true -f "${HOME}/.kube/manifests/metallb-system/metallb-native.yaml"
```
