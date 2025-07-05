# Plateforme CEDILLE - Document de vision

**Organization:** CEDILLE, École de Technologie Supérieure

Voici une vue d'ensemble de la nouvelle plateforme CEDILLE. Cette section est
conçue pour vous donner une vue d'ensemble claire du 'pourquoi' et du 'quoi' de
notre projet. Ici, nous plongeons dans la raison d'être de notre plateforme
basée sur Kubernetes, exploitée par le SaaS Omni de SideroLabs, décrivant en
détail pourquoi nous entreprenons cette aventure et comment nous pensons que
cela va transformer la façon dont on gère nos services d'hébergement sur nos
serveurs bare-metal.

## 1. Survol

### 1.1 Problématique

Le club CEDILLE est responsable de l’hébergement et de l’aide au développement
d’un nombre important de sites et de services web pour les clubs étudiants de
l’ÉTS. De plus, le club cherche à donner à ses membres une occasion
d’apprentissage des technologies DevOps, Kubernetes et de gestion de serveur.

En ce moment, les services sont déployés sur un Kubernetes hébergé par Google
Cloud (GKE). Toutefois, cette plateforme engendre des coûts importants et
l’augmentation de clubs hébergés rend le maintien d’utilisation de cette
plateforme une difficulté financière. De plus, la structure des opérations de
maintenance et de déploiement est en ce moment trop complexe pour assurer une
courbe d’apprentissage intéressante pour les membres du club.

Aussi, la solution actuelle n’offre pas assez de flexibilité et de contrôle pour
permettre aux membres d’expérimenter avec les technologies utilisées. Enfin,
l’ÉTS est en processus de révision de ses pratiques de sécurité suite aux
nouvelles directives gouvernementales, ainsi CEDILLE doit retravailler son
infrastructure pour répondre aux nouvelles exigences.

### 1.2 Objectif

À cause des problèmes mentionnés et des nouveaux requis, le club CEDILLE a
récemment acheté des serveurs physiques et y a installé Kubernetes. La décision
a été prise d’en profiter pour revoir l’ensemble de l’infrastructure et des
systèmes DevOps afin de mieux répondre aux besoins du club, de ses clients et de
l’ÉTS.

Pour ce faire, nous déploierons plusieurs systèmes d'automatisation,
d'observabilité et de redondance. La volonté sera ici de rendre l'expérience des
clients de CEDILLE plus fluide et plus consistante. De plus, nous viserons à
rendre plus clair les processus de développement et de maintenance pour les
membres du club CEDILLE. Lorsque possible, les logiciels libres et cloud-native
seront à favoriser afin de respecter la philosophie du club.

### 1.3 Portée

Cette solution devra être exhaustive afin de couvrir les différents cas
d'utilisation tout en respectant les requis de sécurité demandés par l'ÉTS.
Toutefois, il est important de délimiter ce qui fait partie du projet et ce qui
n'en fera pas parti à ce stade-ci:

#### Inclus

- Toutes les définitions de l'infrastructure et de la typologie réseau
- Les systèmes de redondance
- Les systèmes d'observabilité
- La gestion d'environnements (sandbox, test, et production)
- La gestion des déploiements, notamment progressifs (bleu-vert, canary...)
- Les systèmes de sécurité
- Pipelines de tests et déploiement (CI/CD)

#### Exclus

- Configuration d'environnement de développements pour les développeurs
- Programmation des sites web qui seront sur l'infrastructure
- Effectuer la migration complète de services (certains services en preuve de
  concept d'ici la fin de ce projet, les autres après la fin de ce projet)

### 1.3 Définitions et acronymes

#### Table 1.3.1: Définitions et acronymes\*\*

| **Acronyme**               | Définition                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ÉTS**                    | École de Technologie Supérieure                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| **Docker**                 | Un conteneur est une unité logicielle standard qui regroupe le code et toutes ses dépendances afin que l'application s'exécute rapidement et de manière fiable d'un environnement informatique à un autre. Une image de conteneur Docker est un package logiciel léger, autonome et exécutable qui comprend tout ce dont vous avez besoin pour exécuter une application : code, runtime, outils système, bibliothèques système et paramètres.                                                                                                                                     |
| **Kubernetes**             | Système open source pour automatiser le déploiement, la mise à l'échelle et la gestion des applications conteneurisées.                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| **Cluster**                | Dans un système informatique, un cluster est un groupe de serveurs et d'autres ressources qui agissent comme un système unique et permettent une haute disponibilité, un équilibrage de charge et un traitement parallèle. Ces systèmes peuvent aller d'un système à deux nœuds de deux ordinateurs personnels (PC) à un superordinateur doté d'une architecture en cluster.                                                                                                                                                                                                      |
| **Namespace**              | Dans Kubernetes, les espaces de noms fournissent un mécanisme permettant d'isoler des groupes de ressources au sein d'un seul cluster. Les noms de ressources doivent être uniques au sein d’un espace de noms, mais pas entre les espaces de noms. La portée basée sur l'espace de noms s'applique uniquement aux objets avec espace de noms (par exemple, déploiements, services, etc.) et non aux objets à l'échelle du cluster.                                                                                                                                               |
| **vCluster**               | Clusters Kubernetes virtuels qui s'exécutent dans des espaces de noms (namespace) standards                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **Load balancer**          | L'équilibrage de charge fait référence à la répartition efficace du trafic réseau entrant sur un groupe de serveurs back-end, également appelé batterie de serveurs ou pool de serveurs.                                                                                                                                                                                                                                                                                                                                                                                          |
| **MetalLB**                | MetalLB est une implémentation d'équilibrage de charge pour les clusters Kubernetes sur place (on-prem), utilisant des protocoles de routage standard.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **KubeVirt**               | Extension pour Kubernetes qui permet de gérer et exécuter des machines virtuelles à côté de conteneurs.                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| **Mikrotik**               | Mikrotik est un fournisseur d'équipements réseaux Enterprise à prix raisonnable.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Clickhouse**             | Clickhouse est une base de données à haute performance pour des données à grande échelle.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Logs**                   | Les logs sont des informations purement textuelles provenant d'un service logiciel.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| **Traces**                 | Les traces sont des informations détaillées des opérations internes d'un service logiciel comme le temps de réponse d'une requête SQL.                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **Métriques**              | Les métriques sont des informations usuellement formatées en séries chronologiques qui mesurent des statistiques.                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **OTEL (OpenTelemetry)**   | OpenTelemetry est un projet open source qui définit des protocoles et methodes standards pour la collection et le transfert des Logs, des Traces, et des Métriques.                                                                                                                                                                                                                                                                                                                                                                                                               |
| **BGP**                    | Border Gateway Protocol (BGP) fait référence à un protocole de passerelle qui permet à Internet d'échanger des informations de routage entre des systèmes autonomes (AS).                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Talos Linux**            | Distribution Kubernetes offerte par Sidero Labs                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| **Contour**                | Contour est un contrôleur d'entrée Kubernetes open source fournissant le plan de contrôle pour Envoy Edge et le proxy de service. Contour prend en charge les mises à jour de configuration dynamiques et la délégation d'entrée multi-équipes prêtes à l'emploi tout en conservant un profil léger.                                                                                                                                                                                                                                                                              |
| **Ingress**                | Dans Kubernetes, un Ingress est un objet qui permet de gérer l'accès externe aux services dans un cluster, généralement via HTTP.                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **Egress**                 | Le trafic sortant d'un réseau ou d'un pod dans un contexte Kubernetes.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **Linkerd**                | Un service mesh léger et sécurisé pour Kubernetes qui offre des fonctionnalités telles que le routage du trafic, la télémétrie et la sécurité mTLS.                                                                                                                                                                                                                                                                                                                                                                                                                               |
| **Service mesh**           | Une couche d'infrastructure dédiée pour faciliter les communications orientées services, offrant des fonctionnalités telles que la découverte, la charge, la télémétrie et l'authentification des services.                                                                                                                                                                                                                                                                                                                                                                       |
| **Terraform**              | Terraform est un outil qui permet de faire de l'insfrastructure en tant que code (IaC).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| **Rook/Ceph**              | Rook est une orchestration de stockage pour Kubernetes, et Ceph est un système de stockage distribué que Rook peut orchestrer.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| **Kube-score**             | Kube-score est un outil pour Kubernetes qui recommande des changements pour améliorer la sécurité et la fiabilité.                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| **CI**                     | Intégration continue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| **CD**                     | Déploiement continu                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| **Github Action**          | Github action est l'outil qui permet de faire du CI/CD pour la plateforme Github.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **GitOps**                 | Une méthode pour gérer et mettre à jour les infrastructures et les applications en utilisant des outils Git. Avec GitOps, Git sert de source unique de vérité pour le code et l'infrastructure.                                                                                                                                                                                                                                                                                                                                                                                   |
| **ArgoCD**                 | Un outil déclaratif, GitOps-continu pour Kubernetes.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| **Déploiment Canary**      | Une stratégie de déploiement qui consiste à déployer une nouvelle version d'une application côte à côte avec la version existante, mais à diriger seulement une petite partie du trafic vers la nouvelle version. Si tout va bien, le trafic est progressivement augmenté jusqu'à ce que la nouvelle version prenne la totalité du trafic.                                                                                                                                                                                                                                        |
| **Déploiement Blue-Green** | Une stratégie de déploiement où deux versions de l'application sont maintenues côte à côte (bleue pour l'actuelle, verte pour la nouvelle). Une fois que la nouvelle version (verte) est prête et testée, le routage du trafic est basculé de la version bleue à la version verte. Cela permet des mises à jour sans temps d'arrêt.                                                                                                                                                                                                                                               |
| **Argo Rollouts**          | Extension d'Argo qui fournit des fonctionnalités avancées de déploiement telles que Canary et Blue-Green.                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Kustomize**              | Outil de personnalisation pour les manifests Kubernetes, permettant de définir des variantes d'une base de configuration.                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Odo**                    | Odo est un outil de développement rapide pour les applications Kubernetes et OpenShift, simplifiant le cycle DevOps.                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| **Github registry**        | Un service d'hébergement de packages logiciels lié à GitHub.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **Grafana**                | Une plateforme open source pour la surveillance et l'alerte. Typiquement utilisé en tandem avec Prometheus pour la surveillance des clusters Kubernetes.                                                                                                                                                                                                                                                                                                                                                                                                                          |
| **Pixie**                  | Outil d'observabilité natif pour Kubernetes, permettant de diagnostiquer les applications sans code d'instrumentation.                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **OneUptime**              | OneUptime est une solution complète de suivi et de gestion de vos services en ligne. Que vous ayez besoin de vérifier la disponibilité de votre site Web, de votre tableau de bord, de votre API ou de toute autre ressource en ligne, OneUptime peut alerter votre équipe en cas de temps d'arrêt et tenir vos clients informés avec une page d'état. OneUptime vous aide également à gérer les incidents, à configurer des rotations d'astreinte, à exécuter des tests, à sécuriser vos services, à analyser les journaux, à suivre les performances et à déboguer les erreurs. |
| **Trivy**                  | Un scanner de vulnérabilité de conteneurs simple et complet.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **Cosign**                 | Un outil pour signer et vérifier les signatures des images de conteneurs.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **CodeQL**                 | Une plateforme d'analyse de code source pour trouver les vulnérabilités dans le code. Propriété de GitHub.                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| **Hashicorp Vault**        | Outil pour gérer les secrets et protéger les données sensibles.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| **Kubescape**              | Outil d'analyse pour vérifier la conformité et la sécurité d'un cluster Kubernetes.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| **SonarQube**              | Plateforme d'analyse continue de la qualité du code qui inspecte le code pour détecter les bugs, les odeurs de code et les vulnérabilités de sécurité.                                                                                                                                                                                                                                                                                                                                                                                                                            |

## 2. Position du produit

### 2.1 Énoncé du problème

Le club CEDILLE assume la tâche d'héberger et de soutenir le développement d'une
multitude de sites web et services en ligne pour les associations étudiantes de
l'ÉTS. En outre, le club vise à offrir à ses membres des opportunités
d'acquisition de compétences dans les domaines du DevOps, de Kubernetes et de la
gestion des serveurs.

À l'heure actuelle, notre infrastructure repose sur un cluster Kubernetes géré
par Google Cloud (GKE). Cependant, les frais associés à cette plateforme sont
élevés, et avec l'augmentation du nombre de clubs que nous soutenons, les coûts
deviennent financièrement problématiques. De surcroît, la gestion
majoritairement automatisée par Google Cloud limite notre flexibilité pour
personnaliser nos solutions d'hébergement et restreint les occasions
d'apprentissage pour nos membres.

#### Table 2.1.1: Énoncé du problème

| Déclaration                        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Le problème                        | 1. Contrainte Financière : Le coût de maintien des services sur Google Cloud est significativement élevé et devient de plus en plus difficile à gérer à mesure que le nombre de clubs étudiants hébergés augmente. <br/> 2. Apprentissage et Personnalisation Limités : La gestion de la plupart des opérations par Google Cloud résulte en un environnement restreint qui offre peu d'opportunités pour apprendre et personnaliser les solutions d'hébergement, en particulier dans les domaines du DevOps, de Kubernetes et de la gestion de serveur.                    |
| affecte                            | 1. Durabilité Financière : Le club fait face à un fardeau financier croissant qui pourrait menacer sa capacité à continuer d'offrir des services d'hébergement aux clubs étudiants. <br/> 2. Valeur Éducative : La configuration actuelle limite les expériences d'apprentissage des membres du club, particulièrement dans des domaines pertinents à leur croissance technique comme le DevOps, Kubernetes et la gestion de serveur.                                                                                                                                      |
| et cela se traduit par l'impact de | 1. Tension Financière : Si la situation reste inchangée, le club CEDILLE risque de devenir financièrement insoutenable, ce qui pourrait entraîner l'arrêt des services d'hébergement pour de nombreux clubs étudiants, affectant ainsi leur présence en ligne et leurs opérations. <br /> 2. Développement de Compétences Techniques Réduit : Les membres du club passent à côté d'expériences pratiques et de développement de compétences précieuses, ce qui est l'un des objectifs clés du club pour améliorer l'employabilité et l'expertise technique de ses membres. |

### 2.2 Énoncé du produit

Le club a décidé de migrer les serveurs vers des serveurs physiques, qui seront
déployés à l’ÉTS. Le produit nommé **Plateforme CEDILLE** est une infrastructure
d'hébergement basée sur des serveurs physiques, déployée à l'ÉTS, et gérée via
une licence Omni de Sidero Labs. Cette plateforme vise à offrir une solution
durable et évolutive pour héberger les sites web et les autres services des
clubs étudiants. La plateforme utilise une architecture GitOps, intégrant divers
outils d'automatisation, de surveillance et de sécurité pour simplifier la
gestion tout en maintenant un haut niveau de performance et de sécurité.

#### Tableau 2.2.1: Énoncé du produit

| Déclaration            |                                                                                                                                                                                                                                                                                                                                                                    |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Plateforme CEDILLE est | Une infrastructure d'hébergement locale sur des serveurs physiques, conçue pour réduire les coûts tout en fournissant un environnement flexible et éducatif pour les membres du club CEDILLE.                                                                                                                                                                      |
| ce qui                 | Permet une meilleure maîtrise des coûts et offre des opportunités plus riches pour l'apprentissage et le développement des compétences en DevOps, Kubernetes et gestion de serveur. Elle facilite également la surveillance, la sécurité et l'automatisation, tout en étant suffisamment flexible pour répondre aux besoins spécifiques de divers clubs étudiants. |
| Au contraire de        | L'ancienne infrastructure basée sur Google Cloud (GKE), qui entraînait des coûts élevés et offrait moins de possibilités d'apprentissage et de personnalisation en raison de la gestion centralisée par Google Cloud.                                                                                                                                              |
| Ce produit             | Réduit significativement le fardeau financier du club tout en améliorant la valeur éducative et l'expérience pratique pour les membres. Il offre une solution plus durable et personnalisable pour les besoins d'hébergement des clubs étudiants de l'ÉTS.                                                                                                         |

## 3. Utilisateur et parties prenantes

### 3.1 Sommaire des parties prenantes

Les parties prenantes sont toutes les personnes ou entités ayant un intérêt dans
la réalisation du projet.

#### Table 3.1.1: Résumé des parties prenantes

| **Nom**                                       | **Description**                                                                     | **Responsabilités**                                                                                                                                                             |
| --------------------------------------------- | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **S1** Le club CEDILLE et ses membres         | Club étudiant Open Source de l'École de Technologie Supérieure                      | Conception, mise en place et maintenance de la plateforme CEDILLE.                                                                                                              |
| **S2** Régie des clubs de l'ÉTS               | Organisation au seins de l'ÉTS qui s'occupe de l'administration des clubs étudiants | S'assurer que tous les services mis en place servent les clubs étudiants et respectent la réglementation.                                                                       |
| **S3** Département informatique (TI) de l'ÉTS | Organisation au seins de l'ÉTS qui s'occupe de l'informatique                       | S'assurer que tous nos services sont sécuritaires et n'enfreignent aucune règle.                                                                                                |
| **S4** Les clubs étudiants de l'ÉTS           | Club étudiant de l'École de Technologie Supérieure                                  | Les clubs doivent communiquer clairement leurs besoins et exigences, ainsi que fournir des retours sur les services et les fonctionnalités offertes par la nouvelle plateforme. |

### 3.2 Sommaire des utilisateurs

Les utilisateurs sont toutes les personnes ou entités qui utiliseront ce
produit.

#### Table 3.2.1 : Sommaire des utilisateurs

| **Name**                                                | **Description**                                                                                                                       | **Responsabilités**                                                                            |
|---------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| **U1** Administrateur de la plateforme                  | Administrateur de la plateforme designé par le club CEDILLE                                                                           | Maintenance de la plateforme et approbation d'un nouveau déploiement.                          |
| **U2** Les clubs étudiants et ses membres (Utilisateur) | Club étudiant de l'École de Technologie Supérieure                                                                                    | Interagir avec la plateforme pour obtenir diverses informations sur leurs différents services. |
| **U3** Personnel de l'ETS                               | Régie des clubs étudiants et services TI de l'ÉTS                                                                                     | Vérifier la comformité des applications et de l'infrastructure                                 |
| **U4** Développeurs applicatifs                         | Parfois membres de CEDILLE, parfois d'autres clubs, ils sont responsables de la programmation des logiciels présents sur les serveurs |                                                                                                |


### 3.3 Environnement utilisateur

Les administrateurs de la plateforme **(U1)** peuvent se connecter à la
Plateforme CEDILLE via une interface web ou des outils en ligne de commande pour
gérer les différents services. Le Département informatique de l'ÉTS **(S3)**
veille à ce que la connectivité et la sécurité des services soient maintenues,
tout en respectant les réglementations et les normes en vigueur.

Les clubs étudiants et leurs membres **(U2)** interagissent avec la Plateforme
CEDILLE via des portails web et des applications pour accéder à des
informations, des services et des ressources diverses. Ils doivent également
communiquer leurs besoins et exigences via le serveur Discord.

La réglementation des clubs est supervisée par la Régie des clubs de l'ÉTS
**(S2)**, qui s'assure que la Plateforme CEDILLE sert les intérêts des clubs
étudiants et est en conformité avec la réglementation institutionnelle.

Les clubs étudiants de l'ÉTS **(S4)** jouent un rôle actif en tant que
fournisseurs d'exigences et de commentaires. Ils sont les utilisateurs finaux
des services et ont donc un rôle clé à jouer pour s'assurer que la Plateforme
CEDILLE répond à leurs besoins et attentes.

L'ensemble de la Plateforme CEDILLE et des services connexes doit être conforme
aux normes et aux bonnes pratiques en matière de DevOps telle que défini à la
section [Normes et standards](#71-normes-et-standards).

Toutes les parties doivent respecter les normes et les protocoles mis en place
pour assurer la sécurité, la performance et la disponibilité de la Plateforme
CEDILLE. Ces normes sont définies et maintenues par le club CEDILLE **(S1)** et
le Département informatique de l'ÉTS **(S3)**.

## 3.4 Besoins des principaux utilisateurs

Les besoins sont déterminés à partir d'une série d'entrevues et de rencontres
avec les parties prenantes. Des rapports de ces entrevues et rencontres se
trouvent à l'annexe 1 de ce document.

De plus, les besoins d'administration sont largement déterminés par les auteurs
de ce document, puisqu'ils seront aussi responsables de l'administration de la
plateforme qui sera mise en place.

### Tableau 3.4.1: Définition des priorités

| **Priorité** | **Définition**                                                                                                                      |
| ------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| Critique     | Ce besoin est essentiel à la réussite du projet. S'il n'est pas comblé le projet serait non-fonctionnel                             |
| Important    | Répondre à ce besoin apporte une valeur substantielle au projet; s'il n'est pas comblé il y aura un impact négatif sur l'expérience |
| Facultatif   | Si ce besoin n'est pas comblé, l'expérience demeurera postive même si réduite                                                       |

#### Table 3.4.1: Besoins des principaux utilisateurs

| **ID**  | **Priorité** | **Besoin**                                                                                                                                                                                                                                                                                    |
| ------- | ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **B01** | Critique     | La gestion de la plateforme par les administrateurs (U1) doit pouvoir se faire par différents niveaux de connaissance: des débutants doivent pouvoir gérer la plateforme pour des déploiements de bases et avoir un chemin clair d'apprentissage à travers la plateforme pour devenir experts |
| **B02** | Critique     | Les sites webs des clubs étudiants (U2) doivent être publiquement accessibles sur internet                                                                                                                                                                                                    |
| **B03** | Critique     | Tous les services publics des clubs (U2) doivent utiliser HTTPS                                                                                                                                                                                                                               |
| **B04** | Important    | Les clubs (U2) devraient pouvoir effectuer des changements mineurs aux sites webs par eux-même                                                                                                                                                                                                |
| **B05** | Critique     | L'automatisation des processus doit permettre d'effectuer des changements aux applications des clubs (U2) en moins de 3 jours, incluant le processus de révision et d'approbation                                                                                                             |
| **B06** | Critique     | Des processus d'observabilité doivent permettre aux administrateurs (U1) d'être notifiés de tout problème avec une application d'un club (U2)                                                                                                                                                 |
| **B07** | Important    | Des processus d'observabilité doivent permettre aux capitaines des clubs étudiants (U2) d'être notifiés en cas d'incident                                                                                                                                                                     |
| **B08** | Facultatif   | Les clubs (U2) devraient avoir accès à des tableaux de bord d'observabilité pour leurs applications                                                                                                                                                                                           |
| **B09** | Critique     | Les systèmes doivent être hautement disponibles, de sorte que les mises à jours et les problèmes de serveurs ne causent pas d'indisponibilité                                                                                                                                                 |
| **B10** | Important    | Avoir en place des processus de communication de rapports post-incidents pour les clubs (U2) lors d'incidents de disponibilité et pour l'ÉTS (U3) lors d'incidents de sécurité                                                                                                                |
| **B11** | Critique     | Les bases de données des clubs (U2) et d'administration (U1) doivent pouvoir être restorés en cas de corruption de données ou d'évènements critiques                                                                                                                                          |
| **B12** | Important    | Une documentation orienté utilisateurs/clubs (U2) doit décrire le fonctionnement des outils et des processus                                                                                                                                                                                  |
| **B13** | Critique     | Chaque image déployée doit en tout temps avoir les correctifs de sécurité appliqués. Les services TI (U3) doivent pouvoir vérifier cela                                                                                                                                                       |
| **B14** | Critique     | Le personnel de l'ÉTS (U3) doit pouvoir valider quelles sont les applications déployées sur les serveurs et lesquelles sont publiques                                                                                                                                                         |
| **B15** | Facultatif   | Le personnel de l'ÉTS (U3) doit être notifié lors du déploiement d'une nouvelle application et doit approuver la demande                                                                                                                                                                      |
| **B16** | Critique     | Les services TI (U3) et les administrateurs de la plateforme (U1) doivent pouvoir retracer et annuler tout changement effectué à la plateforme                                                                                                                                                |
| **B17** | Important    | Les administrateur (U1) et les développeurs (U4) doivent avoir accès à des environnements de type "sandbox" pour tester de nouvelles applications et projets                                                                                                                                  |
| **B18** | Important    | Les développeurs (U4) doivent pouvoir tester leur application dans un environnement similaire à la production avant d'effectuer une mise à jour ou un nouveau déploiement                                                                                                                     |
| **B19** | Critique     | Les administrateurs (U1), le personnel de l'ÉTS (U3) et les développeurs applicatifs (U4) doivent avoir accès aux logs, traces et métriques selon ce qui les concerne                                                                                                                         |
| **B20** | Critique     | La gestion de la plateforme pour un administrateur (U1) doit être documentée en détail                                                                                                                                                                                                        |
| **B21** | Critique     | Les tests et déploiements du nouveau code écrit par les développeurs (U4) doivent être automatisés pour réduire la dépendances aux administrateurs (U1)                                                                                                                                       |
| **B22** | Important    | Des systèmes de tests unitaires doivent être mis en place pour le nouveau code écrit par les développeurs (U4)                                                                                                                                                                                |
| **B23** | Facultatif   | Des systèmes de tests de qualité de code doivent être mis en place pour le nouveau code écrit par les développeurs (U4)                                                                                                                                                                       |
| **B24** | Important    | Des systèmes de validation des configurations Kubernetes doivent être mis en place pour éviter des erreurs de configuration par les administrateurs (U4)                                                                                                                                      |
| **B25** | Important    | Des sytèmes de scan doivent détecter le code qui amène des risques de sécurité                                                                                                                                                                                                                |
| **B26** | Critique     | Les secrets que gèrent les administrateurs (U4) doivent être protégés et encryptés pour éviter les accès non-autorisés                                                                                                                                                                        |
| **B27** | Critique     | Les mises à jours doivent être automatisées ou semi-automatisées pour conserver les applications et dépendances à jour                                                                                                                                                                        |
| **B28** | Facultatif   | Les déploiements devraient se faire progressivement, en donnant aux développeurs (U4) le moyen d'annuler en cas d'une augmentation du taux d'erreur                                                                                                                                           |

## 4. Présentation du produit

Le produit est un système qui va permettre le déploiement et l'hébergement
d'applications Web et autres pour les clubs étudiants de l'ÉTS. L'objectif est
que l'architecture du système suit la philosophie du DevOps dans chaque couche
d'implémentation.

### 4.1 Contexte du produit

![Diagramme de contexte](img/platforme_cedille_ctx.svg)

**Figure 4.1.1:** Contexte du produit

### 4.2 Hypothèses et dépendances

Cette section énumère les hypothèses et dépendances qui sont essentielles pour
le développement et le déploiement de la Plateforme CEDILLE.

#### Hypothèses

- Disponibilité du Matériel: Nous supposons que tous les serveurs et équipements
  matériels nécessaires seront disponibles en temps opportun et répondront aux
  spécifications de configuration requises.
- Expertise Technique: L'hypothèse est faite que les membres du club ont ou
  acquerront les compétences nécessaires en technologies DevOps, Kubernetes et
  gestion de serveur.
- Soutien Institutionnel: Nous supposons que l'ÉTS fournira un soutien continu
  pour le projet, notamment en termes d'espaces pour les serveurs et d'accès à
  des ressources en réseau.

#### Dépendances

- Système d'Exploitation: Notre plateforme dépend du système d'exploitation
  Talos linux compatibles avec Kubernetes.
- Kubernetes: Le bon fonctionnement de la plateforme repose sur la dernière
  version stable de Kubernetes.
- Outils de Surveillance: La plateforme dépend de solutions de surveillance
  comme Pixie, OpenTelemetry, ClickHouse et Grafana pour le suivi des
  performances et de l'état du système.

### 4.3 Licence

Étant donné que le club CEDILLE a une dimension éducative et vise à enseigner
les technologies DevOps, Kubernetes, et la gestion de serveur, le choix d'une
licence qui favorise la flexibilité, l'accessibilité et la collaboration est
crucial. C'est pourquoi nous avons opté pour la licence
[Apache 2.0](https://github.com/ClubCedille/Plateforme-Cedille/blob/master/LICENSE)
pour notre infrastructure.

### 4.4 Caractéristiques du produit

#### Tableau 4.4.1: Définition des priorité

| **Priorité** | **Définition**                                                                                   |
| ------------ | ------------------------------------------------------------------------------------------------ |
| Urgente      | Cette caractéristique est nécessaire pour la mise en place de nombreuses autres caractéristiques |
| Importante   | Cette caractéristique bloque quelques autres caractéritiques                                     |
| Nécessaire   | Cette caractéristique ne bloque rien, mais doit être mise en place pour le succès du projet      |
| Facultative  | Cette caractéristique apporte de la valeur, mais n'est pas nécessaire pour le succès du projet   |

#### Tableau 4.4.2 : Caractéristiques du produit

| **ID** | **Priorité** | **Besoins correspondants** | **Description**                                                                                                                                                                                                                                                                                                                |
| ------ | ------------ | -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| CAR1   | Urgente      | B09                        | 6 serveurs (3 controlplanes, 3 workers) seront déployés pour atteindre la haute disponibilité pour la gestion et pour les applications.                                                                                                                                                                                        |
| CAR2   | Urgente      | B13, B26                   | Les serveurs utiliseront le système d'exploitation minimal "Talos OS" afin de réduire la surface d'attaque et de faciliter la gestion et les mises à jours du système d'exploitation par un API web sécurisé.                                                                                                                  |
| CAR3   | Nécessaire   | B01, B16                   | L'infrastructure sera définie _as code_ en utilisant terraform. Il s'agira ici des configurations du matériel réseautique ainsi que des serveurs eux-même.                                                                                                                                                                     |
| CAR4   | Importante   | B02, B03                   | Les serveurs et le routeur utiliseront BGP (MetalLB sur Kubernetes) afin d'avoir de l'équilibrage de charge entre les serveurs.                                                                                                                                                                                                |
| CAR5   | Urgente      | B18                        | Plusieurs environnements seront logiquement séparés en utilisant vCluster afin de créer des environnements Kubernetes virtuels pour la production, le développement et autres.                                                                                                                                                 |
| CAR6   | Urgente      | B03                        | Le programme de _reverse-proxy/ingress_ Contour sera installé et configuré afin de faire le routage des requêtes HTTP et configurer les certificats HTTPS. Ce système ingress est léger et simple à configurer.                                                                                                                |
| CAR7   | Nécessaire   | B28                        | Le programme de service mesh _Linkerd_ sera utilisé pour connecter les applications entre elles de façon sécuritaire et pour gérer les déploiements progressifs.                                                                                                                                                               |
| CAR8   | Urgente      | B11                        | Les disques des serveurs seront gérés par Rook/Ceph avec de la réplication de données afin de réduire les risques de pertes de donnée et les périodes d'instabilité.                                                                                                                                                           |
| CAR9   | Importante   | B11                        | Les données stockés sur Rook/Ceph seront régulièrement sauvegardées sur Google Cloud afin d'assurer la récupération des données dans le cas d'un évènement catastrophique.                                                                                                                                                     |
| CAR10  | Nécessaire   | B13, B14, B25              | Les communications entre les services seront définis via des NetworkPolicies afin de réduire les risques d'attaques via un composant compromis.                                                                                                                                                                                |
| CAR11  | Importante   | B18                        | _Kubevirt_ sera installé et configuré afin de permettre le déploiement de machines virtuelles lorsque la conteneurisation est difficile, voire impossible.                                                                                                                                                                     |
| CAR12  | Importante   | B06, B07, B08              | Une plateforme d'observabilité basée sur OpenTelemetry, Clickhouse et Grafana sera mise en place afin d'identifier plus rapidemement la source de problèmes.                                                                                                                                                                   |
| CAR13  | Importante   | B06, B19                   | Pixie et les outils d'instrumentations d'OpenTelemetry seront utilisés pour recueillir les logs, traces et métriques de Kuberenetes et des applications.                                                                                                                                                                       |
| CAR14  | Importante   | B21                        | Github Actions sera utilisé afin d'éxécuter des pipelines d'intégration.                                                                                                                                                                                                                                                       |
| CAR15  | Importante   | B13                        | Le Github Registry sera utilisé pour stocker les images des conteneurs.                                                                                                                                                                                                                                                        |
| CAR16  | Urgente      | B05, B16                   | ArgoCD sera utilisé comme solution GitOps pour la gestion des déploiements d'applications. Cet outil est _auto-correcting_, c'est-à-dire que toute différence entre l'état actuel et les configurations sur git sera corrigé automatiquement.                                                                                  |
| CAR17  | Nécessaire   | B27                        | Utiliser Dependabot pour ouvrir des PR lors de mises à jours de logiciels ou automatiquement mettre à jour dans le cas des applications sur un répertoire CEDILLE                                                                                                                                                              |
| CAR18  | Importante   | B21                        | Kustomize sera utilisé afin de gérer les ensembles de manifestes Kubernetes de chaque application déployés. Permettra aussi de définir des _layers_ pour la production et pour le développement.                                                                                                                               |
| CAR18  | Importante   | B28                        | Mettre en place un pipeline de déploiements progressifs (_Technologies exactes à définir_)                                                                                                                                                                                                                                     |
| CAR19  | Nécessaire   | B22, B24                   | Kube-Score (bonnes pratiques / erreurs) et Kubescape (sécurité) seront utilisés afin de réviser et tester automatiquement les changements aux manifestes Kubernetes.                                                                                                                                                           |
| CAR20  | Facultative  | B18                        | ODO (Red Hat) sera utilisé pour construire des images automatiquements pour les projets sans Containerfile/Dockerfile et faciliter le développement.                                                                                                                                                                           |
| CAR21  | Urgente      | B26                        | Hashicorp Vault sera déployé et utilisé pour la gestion des secrets. Google KMS sera utilisé pour la décryption de Vault.                                                                                                                                                                                                      |
| CAR22  | Nécessaire   | B13, B25                   | Trivy et Cosign seront utilisés pour tester la sécurité des images et les signer avant leur publication.                                                                                                                                                                                                                       |
| CAR23  | Nécessaire   | B25                        | Github Advanced Security, avec CodeQL, sera utilisé pour trouver les erreurs de sécurité dans le code des applications gérées par CEDILLE.                                                                                                                                                                                     |
| CAR24  | Nécessaire   | B08, B12, B19              | Intégration d'un tableau de bord analytique pour aider les clubs à comprendre l'utilisation et les performances de leurs applications.                                                                                                                                                                                         |
| CAR25  | Nécessaire   | B05, B16                   | Mise en place d'un journal d'audit complet pour suivre tous les changements et opérations réalisés sur la plateforme.                                                                                                                                                                                                          |
| CAR26  | Urgent       | B12, B20                   | Mise à disposition d'un wiki intégré avec des tutoriels, des guides et des FAQ pour les administrateurs et les utilisateurs de la plateforme.                                                                                                                                                                                  |
| CAR27  | Importante   | B17, B18                   | Intégration d'outils de simulation pour aider les développeurs à tester leurs applications dans un environnement similaire à la production.                                                                                                                                                                                    |
| CAR28  | Importante   | B04, B05, B21              | Facilité d'auto-déploiement pour les clubs, à travers une bonne documentation et des pipelines permettant des mises à jour autonomes sans dépendance constante des administrateurs.                                                                                                                                            |
| CAR29  | Importante   | B12, B21, B22, B15         | Intégration de modèles de Pull Request (PR) pour standardiser et rationaliser le processus de soumission de code. Cela aidera à garantir que chaque PR est bien documentée et répond aux normes du club avant la fusion. Notifier et inclure le personnel de l'ÉTS lorsqu'il s'agit du déploiement d'une nouvelle application. |
| CAR30  | Nécessaire   | B12, B21                   | Utilisation de "Code Owners" pour spécifier les responsables de différentes parties du code. Cela garantira que les bonnes personnes sont notifiées pour la revue de chaque PR.                                                                                                                                                |
| CAR31  | Nécessaire   | B12, B20, B21              | Mise en place de guides de contribution pour aider les nouveaux membres ou contributeurs à comprendre comment contribuer correctement au projet.                                                                                                                                                                               |
| CAR32  | Nécessaire   | B12, B21                   | Utilisation de "Issue Templates" pour standardiser la façon dont les problèmes ou les fonctionnalités sont rapportés, facilitant ainsi leur gestion et leur suivi.                                                                                                                                                             |
| CAR33  | Importante   | B21, B22, B23              | Mise en place de _pre-commit-hooks_ pour exécuter automatiquement la vérification à chaque commit du linting ou autres.                                                                                                                                                                                                        |
| CAR34  | Nécessaire   | B05                        | Des environnements devraient être créés lors de Pull Requests pour permettre aux testeurs de valider les changements avant d'accepter ceux-ci                                                                                                                                                                                  |
| CAR35  | Nécessaire   | B10                        | Documenter un processus post-incident, incluant des gabarits de rapports. Définir le processus de communication aux clubs.                                                                                                                                                                                                     |
| CAR36  | Nécessaire   | B01                        | Mettre en place un gabarit de répertoire à l'aide de github-safe-settings permettant d'automatiser les normes et règles d'un projet selon la cadre appliqué.                                                                                                                                                                   |

### 5. Contraintes

**Table 5.1 :Contraintes**

| **ID** | **Contraintes**                                                               | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ------ | ----------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| C01    | Interdiction de stocker des données personelles.                              | Du aux politiques de protection de données de l'ÉTS, on a jugé qu'il est moins risqué pour le projet de ne jamais stocker des données personelles dans la plateforme CEDILLE.                                                                                                                                                                                                                                                                        |
| C02    | Permettre une visibilité complète de notre infrastructure aux services des TI | Les services des TI doivent avoir la capacité de surveiller et d'inspecter tous les services et applications déployés sur la plateforme CEDILLE pour s'assurer qu'ils correspondent strictement aux besoins des clubs et qu'aucun service non lié, comme ceux utilisés pour d'autres activités commerciales, n'est hébergé. Cette exigence découle des problèmes antérieurs rencontrés avec des services non liés déployés sur le réseau de l'école. |
| C03    | Contrôle d'accès résautique partagé avec le service des TI de l'école         | Bien que nous ayons le contrôle sur le routage et la gestion de notre réseau interne grâce à notre routeur, l'accès externe et certaines fonctionnalités du réseau sont strictement contrôlés et gérés par les services TI de l'ÉTS. Toute demande d'accès ou modification du contrôle d'accès externe doit être coordonnée et approuvée par eux.                                                                                                    |

### 6. Attributs de qualité

#### Interopérabilité

AQ1 - Le système doit facilement s'intégrer avec des outils tiers tels que des
services d'observabilité.

#### Performance

AQ2 – La performance des application des clubs doivent être suffisants selon les
besoins de chaque application.

#### Modifiabilité

AQ3 – Tout élement du système doit être facilement modifiable, préférablement
par le code source.

#### Securité

AQ4 – La confidentialité des données doit être conservée en tout temps.

AQ5 – La configuration du sytème est seulement modifiable par les parties
autorisées.

AQ6 – Les secrets sont chriffés au repos et ne sont pas exposés publiquement.

#### Usabilité

AQ6 – Chaque couche du système doit être documentée

AQ7 – Le système doit être compréhensible pour tout membre du club CEDILLE
(nouveaux et anciens).

#### Évolutivité

AQ8 – Le système devrait gérer la mise à l'échelle des applications selon les
besoins en performance.

## 7. Autres exigences

### 7.1 Normes et standards

- On vise à utiliser la norme
  [ISO 32675:2022](https://www.iso.org/standard/83670.html) comme ligne
  directrice pour notre infrastructure.

### 7.2 Exigences en matière de documentation

- Architecture Technique : Schémas et explications détaillées de l'architecture
  des serveurs, du réseau et de la pile technologique.
- Documentation de la Configuration : Instructions pour la mise en place et la
  configuration de l'environnement, y compris les serveurs physiques,
  Kubernetes, et tous les autres outils utilisés.
- Manuel Utilisateur : Documentation destinée aux membres du club et autres
  utilisateurs de la plateforme, expliquant comment déployer et gérer leurs
  services.
- Procédures de Secours et de Restauration : Protocoles à suivre en cas de
  défaillance du système ou d'autres types d'urgences.
