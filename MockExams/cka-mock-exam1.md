## 1.yaml
https://learn.kodekloud.com/user/courses/udemy-labs-certified-kubernetes-administrator-with-practice-tests/module/22051647-8ef0-4f24-8551-caa14ec77d40/lesson/e57ddf3f-4325-4ba3-8a94-833762ec631b

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mc-pod
  namespace: mc-namespace
spec:
  containers:
  - name: mc-pod-1
    image: nginx:1-alpine
    env:
    - name: NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
  - name: mc-pod-2
    image: busybox:1
    command: ["sh", "-c"]
    args:
    - while true; do
        date >> /var/log/shared/date.log;
        sleep 1;
      done
    volumeMounts:
    - name: shared-data
      mountPath: /var/log/shared
  - name: mc-pod-3
    image: busybox:1
    command: ["/bin/sh", "-c"]
    args:
    - tail -f /var/log/shared/date.log
    volumeMounts:
    - name: shared-data
      mountPath: /var/log/shared
  volumes:
  - name: shared-data
    hostPath:
      path: /var/log/shared  # Path on the host node
      type: DirectoryOrCreate    # Creates the directory if it doesn't exist
```


## 10.yaml

```yaml
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: analytics-vpa
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: analytics-deployment
  updatePolicy:
    updateMode: "Auto"
```


## 11.yaml

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: Gateway
metadata:
  name: web-gateway
  namespace: nginx-gateway
spec:
  gatewayClassName: nginx
  listeners:
    - name: http
      protocol: HTTP
      port: 80

```


## 12.yaml

```yaml
helm repo update
helm upgrade kk-mock1 kk-mock1/nginx --version 18.1.15

```


## 3.yaml

```yaml
k get crd -A | grep verticalpod > /root/vpa-crds.txt
```


## 4.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: messaging-service
  name: messaging-service
spec:
  ports:
  - name: redisport
    port: 6379
    protocol: TCP
    targetPort: 6379
  selector:
    tier: msg
  type: ClusterIP
```


## 5.yaml

```yaml
k create deployment hr-web-app --image kodekloud/webapp-color --replicas 2
```


## 6.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: orange
spec:
  containers:
  - command:
    - sh
    - -c
    - echo The app is running! && sleep 3600
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: orange-container
  initContainers:
  - command:
    - sh
    - -c
    - sleep 2; #wrong here, replace sleeep = sleep
    image: busybox
    imagePullPolicy: Always
    name: init-myservice
```


## 7.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: hr-web-app-service
  name: hr-web-app-service
spec:
  ports:
  - name: hr-web-app-port
    port: 8080
    nodePort: 30082
    targetPort: 8080
    protocol: TCP
  selector:
    app: hr-web-app
  type: NodePort
```


## 8.yaml

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


## 9.yaml

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: webapp-hpa
  namespace: default
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: kkapp-deploy
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300

```


## 1.yaml

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-sc
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: kubernetes.io/no-provisioner
reclaimPolicy: Retain # default value is Delete
allowVolumeExpansion: true
mountOptions:
  - discard # this might enable UNMAP / TRIM at the block storage layer
volumeBindingMode: WaitForFirstConsumer
parameters:
  guaranteedReadWriteLatency: "true" # provider-specific

```


## 10.yaml

```yaml
# web-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: web-gateway
  namespace: cka5673
spec:
  gatewayClassName: kodekloud
  listeners:
  - name: https
    protocol: HTTPS
    port: 443
    hostname: kodekloud.com
    tls:
      certificateRefs:
        - name: kodekloud-tls

```


## 2.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: logging-deployment
  name: logging-deployment
  namespace: logging-ns
spec:
  replicas: 1
  selector:
    matchLabels:
      app: logging-app
  template:
    metadata:
      labels:
        app: logging-app
    spec:
      containers:
      - image: busybox
        name: app-container
        command:
          - sh
          - -c
          - "while true; do echo 'Log entry' >> /var/log/app/app.log; sleep 5; done"
        volumeMounts:
        - mountPath: /var/log/app
          name: config-vol

      initContainers:
      - image: busybox
        name: log-agent
        restartPolicy: Always
        command:
          - sh
          - -c
          - "tail -f /var/log/app/app.log"
        volumeMounts:
        - mountPath: /var/log/app
          name: config-vol

      volumes:
      - name: config-vol
        emptyDir: {}
```


## 8.yaml

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: backend-hpa
  namespace: backend
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: backend-deployment
  minReplicas: 3
  maxReplicas: 15
  metrics:
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 65
```


## 1.yaml

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-sc
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: kubernetes.io/no-provisioner
reclaimPolicy: Retain # default value is Delete
allowVolumeExpansion: true
mountOptions:
  - discard # this might enable UNMAP / TRIM at the block storage layer
volumeBindingMode: WaitForFirstConsumer
parameters:
  guaranteedReadWriteLatency: "true" # provider-specific
```


## 10.yaml

```yaml
# web-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: web-gateway
  namespace: cka5673
spec:
  gatewayClassName: kodekloud
  listeners:
  - name: https
    protocol: HTTPS
    port: 443
    hostname: kodekloud.com
    tls:
      certificateRefs:
        - name: kodekloud-tls
```


## 2.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: logging-deployment
  name: logging-deployment
  namespace: logging-ns
spec:
  replicas: 1
  selector:
    matchLabels:
      app: logging-app
  template:
    metadata:
      labels:
        app: logging-app
    spec:
      containers:
      - image: busybox
        name: app-container
        command:
          - sh
          - -c
          - "while true; do echo 'Log entry' >> /var/log/app/app.log; sleep 5; done"
        volumeMounts:
        - mountPath: /var/log/app
          name: config-vol

      initContainers:
      - image: busybox
        name: log-agent
        restartPolicy: Always
        command:
          - sh
          - -c
          - "tail -f /var/log/app/app.log"
        volumeMounts:
        - mountPath: /var/log/app
          name: config-vol

      volumes:
      - name: config-vol
        emptyDir: {}
```


## 8.yaml

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: backend-hpa
  namespace: backend
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: backend-deployment
  minReplicas: 3
  maxReplicas: 15
  metrics:
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 65
```


## 1.yaml

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-sc
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: kubernetes.io/no-provisioner
reclaimPolicy: Retain # default value is Delete
allowVolumeExpansion: true
mountOptions:
  - discard # this might enable UNMAP / TRIM at the block storage layer
volumeBindingMode: WaitForFirstConsumer
parameters:
  guaranteedReadWriteLatency: "true" # provider-specific
```


## 10.yaml

```yaml
# web-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: web-gateway
  namespace: cka5673
spec:
  gatewayClassName: kodekloud
  listeners:
  - name: https
    protocol: HTTPS
    port: 443
    hostname: kodekloud.com
    tls:
      certificateRefs:
        - name: kodekloud-tls
```


## 2.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: logging-deployment
  name: logging-deployment
  namespace: logging-ns
spec:
  replicas: 1
  selector:
    matchLabels:
      app: logging-app
  template:
    metadata:
      labels:
        app: logging-app
    spec:
      containers:
      - image: busybox
        name: app-container
        command:
          - sh
          - -c
          - "while true; do echo 'Log entry' >> /var/log/app/app.log; sleep 5; done"
        volumeMounts:
        - mountPath: /var/log/app
          name: config-vol

      initContainers:
      - image: busybox
        name: log-agent
        restartPolicy: Always
        command:
          - sh
          - -c
          - "tail -f /var/log/app/app.log"
        volumeMounts:
        - mountPath: /var/log/app
          name: config-vol

      volumes:
      - name: config-vol
        emptyDir: {}
```


## 8.yaml

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: backend-hpa
  namespace: backend
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: backend-deployment
  minReplicas: 3
  maxReplicas: 15
  metrics:
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 65
```


## 1.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mc-pod
  namespace: mc-namespace
spec:
  containers:
  - name: mc-pod-1
    image: nginx:1-alpine
    env:
    - name: NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
  - name: mc-pod-2
    image: busybox:1
    command: ["sh", "-c"]
    args:
    - while true; do
        date >> /var/log/shared/date.log;
        sleep 1;
      done
    volumeMounts:
    - name: shared-data
      mountPath: /var/log/shared
  - name: mc-pod-3
    image: busybox:1
    command: ["/bin/sh", "-c"]
    args:
    - tail -f /var/log/shared/date.log
    volumeMounts:
    - name: shared-data
      mountPath: /var/log/shared
  volumes:
  - name: shared-data
    hostPath:
      path: /var/log/shared  # Path on the host node
      type: DirectoryOrCreate    # Creates the directory if it doesn't exist
```


## 10.yaml

```yaml
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: analytics-vpa
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: analytics-deployment
  updatePolicy:
    updateMode: "Auto"
```


## 11.yaml

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: Gateway
metadata:
  name: web-gateway
  namespace: nginx-gateway
spec:
  gatewayClassName: nginx
  listeners:
    - name: http
      protocol: HTTP
      port: 80

```


## 12.yaml

```yaml
helm repo update
helm upgrade kk-mock1 kk-mock1/nginx --version 18.1.15

```


## 3.yaml

```yaml
k get crd -A | grep verticalpod > /root/vpa-crds.txt
```


## 4.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: messaging-service
  name: messaging-service
spec:
  ports:
  - name: redisport
    port: 6379
    protocol: TCP
    targetPort: 6379
  selector:
    tier: msg
  type: ClusterIP
```


## 5.yaml

```yaml
k create deployment hr-web-app --image kodekloud/webapp-color --replicas 2
```


## 6.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: orange
spec:
  containers:
  - command:
    - sh
    - -c
    - echo The app is running! && sleep 3600
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: orange-container
  initContainers:
  - command:
    - sh
    - -c
    - sleep 2; #wrong here, replace sleeep = sleep
    image: busybox
    imagePullPolicy: Always
    name: init-myservice
```


## 7.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: hr-web-app-service
  name: hr-web-app-service
spec:
  ports:
  - name: hr-web-app-port
    port: 8080
    nodePort: 30082
    targetPort: 8080
    protocol: TCP
  selector:
    app: hr-web-app
  type: NodePort
```


## 8.yaml

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


## 9.yaml

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: webapp-hpa
  namespace: default
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: kkapp-deploy
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
```
