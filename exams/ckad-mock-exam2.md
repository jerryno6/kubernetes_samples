# mockExam2

<https://learn.kodekloud.com/user/courses/udemy-labs-certified-kubernetes-application-developer/module/e08a99c2-c477-4e6f-a1b4-9f971c0bf7c9/lesson/93ced20a-8e40-4001-8ada-103ceab9bedb>

## 1

```bash
k create deployment my-webapp --image=nginx --replicas=2 --dry-run=client -oyaml > 1.yaml

update lables tier:frontend

k expose deployment/my-webapp --name=front-end-service --type=NodePort --port=80 --target-port=80 --dry-run=client -oyaml > 11.yaml

update nodeport to 30083
```

## 2

```bash
k taint nodes node01 app_type=alpha:NoSchedule

```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: alpha
spec:
  containers:
  - name: redis
    image: redis
  tolerations:
  - key: "app_type"
    operator: "Equal"
    value: "alpha"
    effect: "NoSchedule"
```

## 3

```yaml
k label node controlplane app_type=beta

k create deployment beta-apps --image=nginx --replicas=3 --dry-run=client -oyaml > 3.yaml
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: beta-apps
  name: beta-apps
spec:
  replicas: 3
  selector:
    matchLabels:
      app: beta-apps
  template:
    metadata:
      labels:
        app: beta-apps
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: app_type
                operator: In
                values:
                - beta
      containers:
      - image: nginx
        name: nginx
```

## 4

```bash
k get ingressclass
```

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minimal-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx # remember to update ingressClassname
  rules:
  - host: ckad-mock-exam-solution.com
    http:
      paths:
      - path: /video
        pathType: Prefix
        backend:
          service:
            name: my-video-service
            port:
              number: 8080

```

## 5

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: pod-with-rprobe
  name: pod-with-rprobe
spec:
  containers:
  - env:
    - name: APP_START_DELAY
      value: "180"
    image: kodekloud/webapp-delayed-start
    imagePullPolicy: Always
    name: pod-with-rprobe
    ports:
    - containerPort: 8080
      protocol: TCP
    livenessProbe:
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 3
      periodSeconds: 10
```

## 6

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: nginx1401
  name: nginx1401
spec:
  containers:
  - image: nginx
    name: nginx1401
    ports:
    - containerPort: 8080
      protocol: TCP
    livenessProbe:
      exec:
        command:
        - ls
        - "/var/www/html/probe"
      initialDelaySeconds: 10
      periodSeconds: 60
```

## 7

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: whalesay
spec:
  template:
    spec:
      restartPolicy: Never
      containers:
      - name: pi
        image: busybox
        command: ["echo", "cowsay I am going to ace CKAD!"]
  completions: 10
  backoffLimit: 6
```

## 8

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: multi-pod
  name: multi-pod
spec:
  containers:
  - name: jupiter
    image: nginx
    env:
    - name: type
      value: planet
  - name: europa
    image: busybox
    command: ["sh", "-c", "sleep 4000"]
    env:
    - name: type
      value: moon
```

## 9

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: custom-volume
spec:
  capacity:
    storage: 50Mi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /opt/data
```
