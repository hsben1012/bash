#!/bin/bash
#check parameter
[ $# == "0" ] && echo Please input u wanted name. [create <user_name>] && exit

cd /home/bigred/kuser && mkdir $1 && cd $1
openssl genrsa -out private.key 2048 &>/dev/null
openssl req -new -key private.key -out CSR.csr -subj "/CN=${1}/O=${1}" &>/dev/null
export BASE64_CSR=$(base64 < CSR.csr | tr -d "\n")
echo -e "apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ${1}-csr
spec:
  groups:
    - system:authenticated
  request: ${BASE64_CSR}
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 31536000
  usages:
    - client auth" > csr.yaml
cat csr.yaml | envsubst | kubectl apply -f -
kubectl certificate approve ${1}-csr
kubectl get csr ${1}-csr -o jsonpath='{.status.certificate}' | base64 -d > k8s-signed.crt
kubectl create ns ${1}
echo -e "apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: ${1}-role
  namespace: ${1}
rules:
- apiGroups: [\"\"]
  resources: [\"*\"]
  verbs: [\"*\"]" > role.yaml
kubectl apply -f role.yaml
echo -e "apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ${1}-rbind
  namespace: ${1}
subjects:
- kind: User
  name: ${1}
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: ${1}-role
  apiGroup: rbac.authorization.k8s.io" > rolebind.yaml
kubectl apply -f rolebind.yaml
