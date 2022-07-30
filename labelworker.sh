#!/bin/bash
kubectl label node w1 node-role.kubernetes.io/worker=
kubectl label node w2 node-role.kubernetes.io/worker=
kubectl get nodes -o wide
