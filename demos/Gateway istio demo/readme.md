# Gateway demo

## Install istio

- Install istio via website ambient mode, download istio file and add it to your PATH
   Follow the instructions at:
`https://istio.io/latest/docs/setup/getting-started/`

`bin/istioctl install --set profile=ambient --skip-confirmation`

- Run the command to install CRD

```bash
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
{ kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.3.0" | kubectl apply -f -; }
```

## Install metalLB

- Install MetalLB <https://metallb.io/installation>

- Config MetalLB using the following command `k apply -f metalLB/metallb-config.yaml`
read more at: <https://metallb.io/installation/>

## Create Apps & routes

- Create a test namespace and set the context to it
`kubectl create ns simple-webapp`
`kubectl create ns nginx`
`kubectl create ns infra`

- Create resources
`kubectl apply -f simple-webapp.yaml`
`kubectl apply -f nginx.yaml`


```
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
  -keyout generic.key -out generic.crt \
  -subj "/CN=example.local" \
  -addext "subjectAltName = DNS:example.local, DNS:*.example.local, DNS:*.wildcard.example.local, IP:192.168.97.10, IP:10.0.0.1"

kubectl create secret tls generic-tls-secret --cert=generic.crt --key=generic.key -n infra
```
`kubectl apply -f gateway.yaml`

Use this command to check the status in eaach namespace
`kubectl config set-context --current --namespace=simple-webapp`
`kubectl config set-context --current --namespace=nginx`
`kubectl config set-context --current --namespace=infra`

## Test the gateway with loadbalancer IP

- Get the external IP of the service `k get svc api-gateway-istio -n infra`

- use the external-IP to access the service
<http://192.168.97.10/nginx>
<http://192.168.97.10/simple-webapp>

## Test the gateway using localhost

If metallb does not work, we can use port-forward to test Run `kubectl port-forward svc/api-gateway-istio -n test 8080:80`

- Open your browser and go to `http://localhost:8080/nginx`