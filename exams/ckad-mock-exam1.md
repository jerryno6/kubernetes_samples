# mockExam1

<https://learn.kodekloud.com/user/courses/udemy-labs-certified-kubernetes-application-developer/module/e08a99c2-c477-4e6f-a1b4-9f971c0bf7c9/lesson/e5093343-1473-4663-9d36-e7d3f8b2ed5c>

## 1

```bash
k run nginx-448839 --image nginx:alpine
```

## 2

```bash
k create namespace apx-z993845
```

## 3

```bash
k create deployment httpd-frontend --image httpd:2.4-alpine --replicas=3
```

## 4

```bash
k run messaging --image redis:alpine --labels=tier=msg
```

## 5

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: rs-d33393
  namespace: default
spec:
  replicas: 4
  selector:
    matchLabels:
      name: busybox-pod
  template:
    metadata:
      labels:
        name: busybox-pod
    spec:
      containers:
      - command:
        - sh
        - -c
        - echo Hello Kubernetes! && sleep 3600
        image: busybox
        imagePullPolicy: IfNotPresent
        name: busybox-container
```

## 6

```yaml
k -n marketing expose deployment/redis --port 6379 --target-port 6379 --name messaging-service
```

## 7

```yaml
kind: Pod
metadata:
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
spec:
  containers:
  - env:
    - name: APP_COLOR
      value: green
    image: kodekloud/webapp-color
    imagePullPolicy: Always
    name: webapp-color
```

## 8

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: cm-3392845
data:
  DB_NAME: "SQL3322"
  DB_HOST: "sql322.mycompany.com"
  DB_PORT: "3306"
```

## 9

```bash
kubectl create secret generic db-secret-xxdf \
  --from-literal=DB_Host=sql01 \
  --from-literal=DB_User=root \
  --from-literal=DB_Password=password123
```

## 10

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app-sec-kff3345
  namespace: default
spec:
  containers:
  - command:
    - sleep
    - "4800"
    image: ubuntu
    name: ubuntu
    securityContext:
      runAsUser: 0       # 0 is the user ID for root
      capabilities:
        add: ["SYS_TIME"]  # Adding the SYS_TIME capability
```

## 11

```bash
 k -n e-commerce logs e-com-1123 > /opt/outputs/e-com-1123.logs
```

## 12

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-analytics
spec:
  capacity:
    storage: 100Mi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteMany
  hostPath:
      path: /pv/data-analytics
```

## 13

```bash
k create deployment redis --image=redis:alpine --replicas=1 --dry-run=client -o yaml > 13.yaml

k apply -f 13.yaml

k expose deployment/redis --name=redis --port=6379 --target-port=6379

```

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: redis-access
spec:
  podSelector:
    matchLabels:
      app=redis
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          access: redis
    ports:
    - protocol: TCP
      port: 6379
```

## 14

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sega
spec:
  containers:
  - name: tails
    image: busybox
    command: ["sleep", "3600"]
  - name: sonic
    image: nginx
    env:
      - name: NGINX_PORT
        value: "8080"
```
