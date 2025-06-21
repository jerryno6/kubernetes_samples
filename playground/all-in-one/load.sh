#!/bin/bash

#timeout 1000s bash -c 'for i in {1..10}; do (while true; do curl -s http://192.168.194.197:8080; done) & done; wait'
bash -c 'for i in {1..10}; do (while true; do curl -s http://192.168.194.197:8080; done) & done; sleep 300 && pkill -P $$' &

kubectl run -i --tty load-test --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://webapp-service:31031; done"