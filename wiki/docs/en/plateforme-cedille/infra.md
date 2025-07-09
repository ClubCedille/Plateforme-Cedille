# Club Infrastructure

CEDILLE uses Proxmox to centralize the resources of the physical servers.
Specifically, Proxmox allows us to aggregate the resources (CPU, RAM, and
storage) of our three physical servers pve01, pve02, and pve03 to create a
resource pool that will then be used by Kubernetes. Proxmox also enables us to
unify and manage the storage of the different servers through Ceph. Ceph will
handle, among other things, making hourly backups that will be saved on our
backup server and daily backups that will be stored using Backblaze on a server
located outside of ÉTS to ensure optimal resilience.
![infra](img/infra-cedille.png)
