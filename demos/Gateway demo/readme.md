1. Install istio via website sidecar mode, download istio file and add it to your PATH.
   Follow the instructions at:
`https://istio.io/latest/docs/setup/getting-started/`

2. Then apply the file gateway.yaml

3. run `kubectl port-forward svc/api-gateway-istio -n istio 8080:8080`

4. Open your browser and go to `http://localhost:8080/nginx`
