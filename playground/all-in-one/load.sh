#!/bin/bash

timeout 1000s bash -c 'for i in {1..10}; do (while true; do curl -s http://localhost:30080; done) & done; wait'