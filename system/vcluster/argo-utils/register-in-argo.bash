#!/bin/bash

POD_NAME="argocd-debug"

kubectl config set-context --current --namespace=argocd

#0. Create a pod with ArgoCD CLI and ServiceAccount with full k8s API access.
kubectl apply -f debug-namespace.yaml
kubectl create sa debug-admin -n script-temp-001
kubectl create clusterrolebinding debug-admin --clusterrole cluster-admin --serviceaccount script-temp-001:debug-admin
kubectl apply -f argocd-debug-pod.yaml
echo "Waiting..."
sleep 5
kubectl exec $POD_NAME -n script-temp-001 -- bash -c "apt update ; apt install curl ; curl -LO \"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl\" ; install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl"

#1. Create kubeconfig yaml files
vcluster connect vcluster-staging -n vcluster-staging --server=vcluster-staging.vcluster-staging.svc.cluster.local --insecure --update-current=false --kube-config staging.vc.yaml
vcluster connect vcluster-prod    -n vcluster-prod    --server=vcluster-prod.vcluster-prod.svc.cluster.local       --insecure --update-current=false --kube-config prod.vc.yaml
vcluster connect vcluster-sandbox -n vcluster-sandbox --server=vcluster-sandbox.vcluster-sandbox.svc.cluster.local --insecure --update-current=false --kube-config sandbox.vc.yaml

#2. Transfer yamls to argocd pod
kubectl cp kursedconfig.yaml "$POD_NAME:/tmp" -n script-temp-001
kubectl cp kursed.bash "$POD_NAME:/tmp" -n script-temp-001

kubectl cp staging.vc.yaml "$POD_NAME:/tmp" -n script-temp-001
kubectl cp prod.vc.yaml "$POD_NAME:/tmp" -n script-temp-001
kubectl cp sandbox.vc.yaml "$POD_NAME:/tmp" -n script-temp-001

#2.1 Template the Kubeconfig for the local cluster to make kubectl work properly
# kubectl exec $POD_NAME -n script-temp-001 -- bash -c "dqt='"' ; sed -i \"s|__CACERT__|$(cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt | base64 -w0)|\" /tmp/kursedconfig.yaml ; sed -i \"s|__TOKEN__|$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)|\" /tmp/kursedconfig.yaml"
# kubectl exec $POD_NAME -n script-temp-001 -- bash -c "dqt='"' ; sed -i \"s|__CACERT__|$(cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt | base64 -w0 | tr -d '\n')|\" /tmp/kursedconfig.yaml ; sed -i \"s|__TOKEN__|$(cat /var/run/secrets/kubernetes.io/serviceaccount/token | tr -d '\n')|\" /tmp/kursedconfig.yaml"
kubectl exec $POD_NAME -n script-temp-001 -- bash "../../tmp/kursed.bash"


#3. Register the vclusters in ArgoCD
kubectl exec $POD_NAME -n script-temp-001 -- bash -c "KUBECONFIG=../../tmp/kursedconfig.yaml ; kubectl config set-context --current --namespace=argocd"
kubectl exec $POD_NAME -n script-temp-001 -- bash -c "KUBECONFIG=../../tmp/kursedconfig.yaml ; argocd login --core ; argocd --loglevel=debug cluster add vcluster_vcluster-staging_vcluster-staging_cedille-cedille-cluster -y --kubeconfig=../../tmp/staging.vc.yaml"
kubectl exec $POD_NAME -n script-temp-001 -- bash -c "KUBECONFIG=../../tmp/kursedconfig.yaml ; argocd login --core ; argocd --loglevel=debug cluster add vcluster_vcluster-prod_vcluster-prod_cedille-cedille-cluster -y --kubeconfig=../../tmp/prod.vc.yaml"
kubectl exec $POD_NAME -n script-temp-001 -- bash -c "KUBECONFIG=../../tmp/kursedconfig.yaml ; argocd login --core ; argocd --loglevel=debug cluster add vcluster_vcluster-sandbox_vcluster-sandbox_cedille-cedille-cluster -y --kubeconfig=../../tmp/sandbox.vc.yaml"

#99. Cleanup.
kubectl delete namespace script-temp-001
kubectl delete clusterrolebinding debug-admin