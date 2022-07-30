#!/bin/bash
#check parameter
[ $# == "0" ] && echo "Please input u wanted name. [config <user_name>]" && exit

cd /home/bigred/kuser/$1
kubectl config view --flatten=true | head -n 6 > config.tmp
echo -e "contexts:
  - context:
      cluster: kubernetes
      user: ${1}
    name: ${1}-context
current-context: ${1}-context
kind: Config
preferences: {}
users:
  - name: ${1}
    user:
      client-certificate-data: ${K8S_CRT}
      client-key-data: ${K8S_KEY}" >> config.tmp
export K8S_CRT=$(base64 < k8s-signed.crt | tr -d "\n")
export K8S_KEY=$(base64 < private.key | tr -d "\n")
cat config.tmp | envsubst > config
cat config