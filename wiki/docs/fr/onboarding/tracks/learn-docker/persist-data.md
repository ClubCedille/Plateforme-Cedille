Docker isole tout le contenu, le code et les données à l'intérieur d'un
conteneur par rapport au système de fichiers local. Cela signifie que lorsque
vous supprimez un conteneur, tout le contenu à l'intérieur est également
supprimé. Parfois, vous souhaiterez peut-être conserver les données générées par
un conteneur. C'est là que les volumes Docker deviennent utiles.

## Utilisation des Volumes Docker pour Persister les Données

Si vous souhaitez conserver des données même après la suppression d'un
conteneur, vous pouvez utiliser un volume. Un volume est un emplacement dans
votre système de fichiers local géré par Docker. Les volumes sont utiles car ils
permettent de stocker des données en dehors du cycle de vie du conteneur.

### Exemple : Ajouter un Volume à un Projet Docker Compose

Nous allons réutiliser le dépôt à l'adresse
[https://github.com/docker/multi-container-app](https://github.com/docker/multi-container-app)
pour démontrer comment ajouter un volume à un projet Docker Compose.

**1. Cloner le Dépôt :**

   ```
   git clone https://github.com/docker/multi-container-app
   cd multi-container-app
   ```

**2. Modifier le Fichier `compose.yaml` :**

   Pour ajouter un volume à ce projet, ouvrez le fichier `compose.yaml` et
   décommentez les lignes suivantes :

   ```yaml
   services:
     todo-database:
       # ...
       volumes:
         - database:/data/db

   # ...
   volumes:
     database:
   ```

**Explication :**

   - L'élément `volumes` imbriqué dans `todo-database` indique à Compose de
     monter le volume nommé `database` sur `/data/db` dans le conteneur pour le
     service `todo-database`.
   - L'élément `volumes` de niveau supérieur définit et configure un volume
     nommé `database` qui peut être utilisé par n'importe quel service dans le
     fichier Compose.

**3. Lancer l'Application Docker Compose :**

   Ouvrez un terminal dans votre répertoire de projet et exécutez la commande suivante :
   ```
   docker-compose up -d
   ```

   Cette commande démarrera l'application avec le volume configuré. Docker
   vérifiera l'existence du volume `database` et le créera s'il n'existe pas.

**4. Persistance des Données :**

   Maintenant, peu importe à quelle fréquence vous supprimez et redémarrez le
   conteneur, vos données sont persistées. Les données stockées dans le
   répertoire `/data/db` à l'intérieur du conteneur sont sauvegardées dans le
   volume `database`. Ce volume est accessible à tout conteneur sur votre
   système en montant le volume `database`.

   Pour arrêter et supprimer les conteneurs, les réseaux et les volumes créés par `docker-compose up`, utilisez :
   ```
   docker-compose down
   ```

   Pour supprimer également le volume, utilisez :
   ```
   docker-compose down -v
   ```

## Résumé

Les volumes dans Docker offrent un moyen puissant de persister et de partager
des données entre les conteneurs. Ils garantissent que vos données restent
intactes et accessibles même si les conteneurs sont supprimés ou redémarrés. En
utilisant les volumes, vous pouvez créer des applications conteneurisées
robustes et fiables qui gèrent et stockent les données efficacement.
