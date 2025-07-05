# Infrastructure du club

CEDILLE utilise Proxmox pour centraliser les ressources des serveurs
physiques. Concrètement, Proxmox permet d'agréger les ressources(CPU,RAM et
storage) de nos trois serveurs physiques pve01, pve02 et pve03 pour créer un
réservoir des ressources qui sera ensuite utilisé par Kubernetes. Proxmox nous
permet aussi d'unifier et de faire la gestion du stockage des différents
serveurs à travers de Ceph. Ceph se chargera, entre autres, de faire des copies
de sauvegarde (back ups) horaires qui seront enregistrées dans notre serveur des
back ups et des copies de sauvegarde journalières qui seront stockées à l'aide
de Backblaze dans un servers qui ne réside pas à l'ÉTS afin d'assurer une
résilience optimale. ![infra](img/infra-cedille.png)
