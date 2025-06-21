# mockExam3

<https://learn.kodekloud.com/user/courses/udemy-labs-certified-kubernetes-administrator-with-practice-tests/module/22051647-8ef0-4f24-8551-caa14ec77d40/lesson/45b2b360-9754-4623-ad11-42289456db72?autoplay=true>

## 1

```bash
sudo modprobe br_netfilter
sudo sysctl net.bridge.bridge-nf-call-iptables=1

sudo sysctl net.ipv4.ip_forward=1
```

## 2

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: pvviewer
  namespace: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: pvviewer-role
rules:
- apiGroups: [""]
  resources: ["persistentvolumes"]
  verbs: ["list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: pvviewer-role-binding
subjects:
- kind: ServiceAccount
  name: pvviewer
  namespace: default
roleRef:
  kind: ClusterRole
  name: pvviewer-role
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: v1
kind: Pod
metadata:
  name: pvviewer
  namespace: default
spec:
  serviceAccountName: pvviewer
  containers:
  - name: redis
    image: redis
```

## 3

```txt
```

## 4

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: cm-namespace
data:
  # property-like keys; each key maps to a simple value
  ENV: "production"
  LOG_LEVEL: "info"
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  labels:
    app: cm-webapp
  name: cm-webapp
  namespace: cm-namespace
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: cm-webapp
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: cm-webapp
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        resources: {}
        env:
          - name: ENV
            valueFrom:
              configMapKeyRef:
                name: app-config
                key: ENV
          - name: LOG_LEVEL
            valueFrom:
              configMapKeyRef:
                name: app-config
                key: LOG_LEVEL
                              
```

## 5

```bash
kubectl create priorityclass low-priority --value=50000 --description="low priority"
```

Add/update these lines

```yaml
  priorityClassName: low-priority
  priority: 50000
  containers: ...
```

## 6

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-to-nptest
spec:
  podSelector:
    matchLabels:
      run: np-test-1
  policyTypes:
    - Ingress
  ingress:
    - ports:
        - protocol: TCP
          port: 80
```

## 7

```bash
kubectl taint nodes node01 env_type=production:NoSchedule

k run dev-redis --image redis:alpine
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: prod-redis
spec:
  containers:
  - name: redis
    image: redis:alpine
  tolerations:
  - key: "env_type"
    operator: "Equal"
    value: "production"
    effect: "NoSchedule"

```

## 8

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"PersistentVolumeClaim","metadata":{"annotations":{},"name":"app-pvc","namespace":"storage-ns"},"spec":{"accessModes":["ReadWriteMany"],"resources":{"requests":{"storage":"1Gi"}}}}
  creationTimestamp: "2025-06-06T09:36:03Z"
  finalizers:
  - kubernetes.io/pvc-protection
  name: app-pvc
  namespace: storage-ns
  resourceVersion: "6810"
  uid: 7ede9f65-9003-4047-9849-72e90736ca6a
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  volumeMode: Filesystem
status:
  phase: Pending
```

## 9

- below is the sample yaml
- What we need to fix: is to replace `:9999` by `:6443`

```yaml
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    namespace: storage-ns
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED
```

## 10

```txt
k get pods -A

describe the pods that is not running that dislay with 0/1

fix for the wrong name of the kube-controller in /etc/kubernetes/manifest/kube-controller.yaml 
```

## 11

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api-hpa
  namespace: api
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api-deployment
  minReplicas: 1
  maxReplicas: 20
  metrics:
  - type: Pods
    pods:
      metric:
        name: requests_per_second
      target:
        type: AverageValue
        averageValue: 1000
```

## 12

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: web-route
spec:
  parentRefs:
  - name: web-gateway
    kind: Gateway
  rules:
  - backendRefs:
    - name: web-service
      port: 80
      weight: 80
    - name: web-service-v2
      port: 80
      weight: 20
```

## 13

```bash
helm ls -n default

cd /root/
helm lint ./new-version

helm install webpage-server-02 ./new-version

helm uninstall webpage-server-01 -n default
```

## 14

```bash
kubectl get node controlplane -o jsonpath="{.spec.podCIDR}" > /root/pod-cidr.txt
```
