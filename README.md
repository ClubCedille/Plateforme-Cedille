# Plateforme CEDILLE

Code terraform pour configurer Github, Omni et plus...

## Configuration des clubs

Les définitions des clubs et leurs accès transverses (Nextcloud, Authentik,
Forgejo, Matomo) vivent dans [`clubs/`](./clubs/README.md).

Le workflow `Render club configuration` valide ces fichiers et génère les
artefacts consommés par `k8s-shared`. Ne pas modifier directement les fichiers
générés dans `k8s-shared`.

## RBAC Kubernetes et comptes Omni

Le niveau d'accès Kubernetes vient des groupes d'impersonation déclarés dans
les ACL (`kubernetes.impersonate.groups`), pas du nom du rôle Omni. Voir
[`k8s-base/common/rbac/README.md`](https://github.com/ClubCedille/k8s-base/blob/master/common/rbac/README.md)
pour le modèle complet et les groupes `cedille-reader` / `cedille-operator`.

Un rôle Omni `Operator` ou `Admin` ajoute automatiquement le groupe Kubernetes
`system:masters` (cluster-admin) sur tous les clusters, et RBAC ne peut pas le
retirer. Pour donner un accès operator sans faire la personne Omni Operator,
utiliser `cluster_role = "Reader"` et
`kubernetes_groups = ["cedille-operator"]` (voir
`terraform/examples/rbac-poc.tf.example`).

La variable `cluster_name` vaut maintenant `k8s-shared` par défaut et refuse un
nom qui ne commence pas par `k8s-`, pour éviter l'ancien `cedille-cluster` qui
n'existe plus (les règles ACL ne matchaient alors aucun cluster).

Chaque ACL générée contient aussi un bloc `spec.tests` : `omnictl apply`
vérifie que l'utilisateur obtient bien le rôle et les groupes Kubernetes
attendus, et rejette la politique si le résultat diffère.
