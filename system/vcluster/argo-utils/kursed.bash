#!/bin/bash
CACERT_CONTENT=$(cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt | base64 -w0 | tr -d '\n')
TOKEN_CONTENT=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token | tr -d '\n')

sed -i "s|__CACERT__|$CACERT_CONTENT|" /tmp/kursedconfig.yaml
sed -i "s|__TOKEN__|$TOKEN_CONTENT|" /tmp/kursedconfig.yaml