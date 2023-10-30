#!/bin/bash

mkdir .vault-keys
kubectl create ns vault
kubectl label vault pod-security.kubernetes.io/enforce=privileged

openssl genrsa -out .vault-keys/vault.key 2048
openssl req -new -key .vault-keys/vault.key -out .vault-keys/vault.csr -config vault-csr.conf

cat > .vault-keys/csr.yaml <<EOF
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
   name: vault.svc
spec:
   signerName: kubernetes.io/kubelet-serving
   expirationSeconds: 8640000
   request: $(cat .vault-keys/vault.csr|base64|tr -d '\n')
   usages:
   - digital signature
   - key encipherment
   - server auth
EOF

kubectl create -f .vault-keys/csr.yaml
kubectl certificate approve vault.svc

kubectl get csr vault.svc -o jsonpath='{.status.certificate}' | openssl base64 -d -A -out .vault-keys/vault.crt
kubectl config view \
--raw \
--minify \
--flatten \
-o jsonpath='{.clusters[].cluster.certificate-authority-data}' \
| base64 -d > .vault-keys/vault.ca

kubectl create secret generic vault-ha-tls \
   -n vault \
   --from-file=vault.key=.vault-keys/vault.key \
   --from-file=vault.crt=.vault-keys/vault.crt \
   --from-file=vault.ca=.vault-keys/vault.ca

terraform -chdir=../../terraform output -raw vault_kms_service_account > .vault-keys/credentials.json