# demo loadbalancer locally

1. Install MetalLB `https://metallb.io/installation/`

1. Config MetalLB with a pool of IPs that you can use for your services. For example, if you are using Kind, you can use the following config `https://metallb.io/configuration/`
`k apply -f metallb-config.yaml`

1. `k apply -f loadbalancer.yaml`

1. Run `k get svc` to see the service created by MetalLB, see the external IP assigned to the service.
goto : `http://<external-ip>:8080`
