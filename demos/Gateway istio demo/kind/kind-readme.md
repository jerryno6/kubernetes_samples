# Kind Cluster Setup

## Create a Kind Cluster

```bash
kind create cluster --name kind --config kind-config.yaml
```

## Load Images into Kind Cluster

```bash
kind load docker-image <your-image> --name istio-demo
```

Delete the cluster
```
kind delete cluster --name kind
```