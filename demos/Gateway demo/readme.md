# Gateway demo

1. Install istio via website sidecar mode, download istio file and add it to your PATH
   Follow the instructions at:
`https://istio.io/latest/docs/setup/getting-started/`

`bin/istioctl install -y`

```bash
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
{ kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.3.0" | kubectl apply -f -; }
```

2. Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later:
`k create ns test`
`k config set-context --current --namespace=test`
`kubectl label namespace test istio-injection=enabled`

3. Create resources
`kubectl apply -f deployment.yaml`

`kubectl apply -f gateway.yaml`

4. run `kubectl port-forward svc/api-gateway-istio -n test 8080:80`

5. Open your browser and go to `http://localhost:8080/nginx`
