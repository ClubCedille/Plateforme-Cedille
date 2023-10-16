#!/bin/bash

read -p "THIS WILL WIPE ALL THE CEPH CLUSTER DISKS, ARE YOU SURE? (write yes i am sure): " confirmation
if [[ "$confirmation" != "yes i am sure" ]]
then
    exit;
fi

image_count=0
node_count=$(cat CephCluster.yaml | yq -cr '.spec.storage.nodes | length')
for ((i=0; i<$node_count; i++))
do
    NODE=$(cat CephCluster.yaml | yq -cr ".spec.storage.nodes[$i].name");
    echo $NODE
    node_disks=$(cat CephCluster.yaml | yq -cr ".spec.storage.nodes[$i].devices[].name")
    for DISK in $node_disks
    do
        echo starting wiping job for $DISK on $NODE...
        kubectl run wipe-disk-$image_count --image=quay.io/ceph/ceph:v17.2.6 -n rook-ceph --overrides="{\"apiVersion\":\"v1\",\"spec\":{\"nodeSelector\":{\"kubernetes.io/hostname\":\"$NODE\"},\"restartPolicy\":\"Never\",\"containers\":[{\"name\":\"ubuntu\",\"image\":\"quay.io/ceph/ceph:v17.2.6\",\"command\":[\"/bin/bash\", \"-c\"],\"args\":[\"sgdisk --zap-all $DISK; dd if=/dev/zero of='$DISK' bs=1M count=100 oflag=direct,dsync; partprobe $DISK;\"],\"volumeMounts\":[{\"name\":\"device-dir\",\"mountPath\":\"/dev\"}],\"securityContext\":{\"privileged\":true}}],\"volumes\":[{\"name\":\"device-dir\",\"hostPath\":{\"path\":\"/dev\"}}]}}"
        image_count=$(($image_count+1))
    done
    echo starting wiping LVMs job for $NODE...
    kubectl run wipe-lvms-$NODE --image=quay.io/ceph/ceph:v17.2.6 -n rook-ceph -it --overrides="{\"apiVersion\":\"v1\",\"spec\":{\"nodeSelector\":{\"kubernetes.io/hostname\":\"$NODE\"},\"restartPolicy\":\"Never\",\"containers\":[{\"name\":\"ubuntu\",\"image\":\"quay.io/ceph/ceph:v17.2.6\",\"command\":[\"/bin/bash\", \"-c\"],\"args\": [\"ls /dev/mapper/ceph-* | xargs -I% -- dmsetup remove %; rm -rf /dev/ceph-*; rm -rf /dev/mapper/ceph--*\"],\"volumeMounts\":[{\"name\":\"device-dir\",\"mountPath\":\"/dev\"}],\"securityContext\":{\"privileged\":true}}],\"volumes\":[{\"name\":\"device-dir\",\"hostPath\":{\"path\":\"/dev\"}}]}}"
done