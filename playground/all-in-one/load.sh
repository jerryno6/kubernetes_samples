#!/bin/bash

kubectl run -i --tty hpa-test --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- webapp-service:8080; done"