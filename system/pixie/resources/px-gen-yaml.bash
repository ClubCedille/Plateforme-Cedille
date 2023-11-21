#!/bin/bash
echo "deleting old yamls..."
rm -rf ./pixie_yamls
#echo "make sure to set PIXIE_DEPLOYMENT_KEY env var first... generate it with px deploy-key create"
px deploy --extract_yaml ./ --deploy_key FAKE_KEY --pem_memory_limit=3Gi
tar -xvf yamls.tar
rm -f yamls.tar