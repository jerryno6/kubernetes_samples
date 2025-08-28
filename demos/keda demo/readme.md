# KEDA demo

## setup keda

```bash
helm repo add kedacore ht‌tps://kedacore.github.io/charts
helm repo update
helm install -i keda kedacore/keda --namespace keda --create-namespace
```
