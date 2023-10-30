#!/bin/bash

kubectl delete secret gcp-secret

# Set the variables
SERVICE_ACCOUNT_NAME="crossplane-sa"
KUBE_NAMESPACE="crossplane"
YOUR_PROJECT_ID="fine-harbor-276700" # Replace with your GCP project ID

# Step 1: Create a service account with access to DNS and storage APIs and save it to serviceaccount.json
gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME --display-name $SERVICE_ACCOUNT_NAME
gcloud projects add-iam-policy-binding $YOUR_PROJECT_ID --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$YOUR_PROJECT_ID.iam.gserviceaccount.com" --role="roles/dns.admin"
gcloud projects add-iam-policy-binding $YOUR_PROJECT_ID --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$YOUR_PROJECT_ID.iam.gserviceaccount.com" --role="roles/storage.admin"
gcloud iam service-accounts keys create serviceaccount.json --iam-account=$SERVICE_ACCOUNT_NAME@$YOUR_PROJECT_ID.iam.gserviceaccount.com

# Step 2: Store the service account as a Kubernetes secret
kubectl create secret generic gcp-secret -n $KUBE_NAMESPACE --from-file=creds=./serviceaccount.json

# Clean up the service account key file
rm serviceaccount.json

echo "Service account created and stored as a Kubernetes secret."
