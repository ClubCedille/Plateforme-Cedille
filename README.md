# Plateforme CEDILLE

Code terraform pour configurer Github, Omni et plus...

## Configuration des clubs

Les définitions des clubs et leurs accès transverses (Nextcloud, Authentik,
Forgejo, Matomo) vivent dans [`clubs/`](./clubs/README.md).

Le workflow `Render club configuration` valide ces fichiers et génère les
artefacts consommés par `k8s-shared`. Ne pas modifier directement les fichiers
générés dans `k8s-shared`.
