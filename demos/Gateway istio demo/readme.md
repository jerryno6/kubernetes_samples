# Gateway demo

## Install istio
1. Install istio via website ambient mode, download istio file and add it to your PATH
   Follow the instructions at:
`https://istio.io/latest/docs/setup/getting-started/`

`bin/istioctl install --set profile=ambient --skip-confirmation`

```bash
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
{ kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.3.0" | kubectl apply -f -; }
```

## Install metalLB

2.1 Install MetalLB `https://metallb.io/installation/`

2.2 Config MetalLB with a pool of IPs that you can use for your services. For example, if you are using Kind, you can use the following config `https://metallb.io/configuration/`
`k apply -f metallb-config.yaml`

## Create Apps & routes

3. Create a test namespace and set the context to it
`k create ns test`
`k config set-context --current --namespace=test`

4. Create resources
`kubectl apply -f my-app.yaml`

`kubectl apply -f gateway.yaml`

## Test the gateway with loadbalancer IP

5. Get the external IP of the service `k get svc api-gateway-istio -n test`

6. use the external-IP to access the service: `http://192.168.97.10/nginx`

## Test the gateway using localhost

7. If metallb does not work, we can use port-forward to test Run `kubectl port-forward svc/api-gateway-istio -n test 8080:80`

8. Open your browser and go to `http://localhost:8080/nginx`
