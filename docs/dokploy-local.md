# Dockploy Local Installation

## Prerequisites

Nécessite un système d'exploitation Linux.
Nous utilisons Ubuntu 24.04 LTS dans unos exemples.

Pour MacOS, il est possible d'utiliser OrbStack (VM légère).

## Installer Ubuntu via OrbStack (MacOS)

Installer [OrbStack](https://orbstack.com/) en suivant les instructions sur leur site.

```bash
brew install orbstack
```

Créer un VM Ubuntu 24.04 LTS dans OrbStack.

```bash
orb create ubuntu:24.04 ubuntu-dokploy
```

Lancer ou arrêter la VM.

```bash
orb start ubuntu-dokploy
orb stop ubuntu-dokploy
```

Se connecter à la VM en SSH.

```bash
ssh root@ubuntu-dokploy@orb
```

Installer les packets de base en suivant le [guide Common Install](./common-install.md) : Tree, Make, Lazydocker.

Installer Docker en suivant le [guide Docker Install](./docker-install.md).

## Installer Dokploy dans OrbStack

Lancer le script d'installation de Dokploy.

```bash
curl -sSL https://dokploy.com/install.sh | sh
```

Le script indique que le serveur est accessible via [http://81.65.139.132:3000](http://81.65.139.132:3000) (machine virtuelle OrbStack, Ubuntu 24).
Cet IP n'est pas directement accessible. Cependant, OrbStack redirige automatiquement la connexion vers [localhost:3000](http://localhost:3000) (sur la machine hôte, MacOS).

Accéder à l'interface web de Dokploy via l'URL : [localhost:3000](http://localhost:3000).

## OrbStack et Traefik

URL qui pourrait être utiles ?

-   [https://orb.local/](https://orb.local/)
-   [https://traefik.me/](https://traefik.me/)

## Déployer une application Next.js

1. Créer un `Projet` puis un `Service` de type `Compose` > `Docker Compose`.
2. Onglet `General` > section `Provider` puis source `Git`
    - `Repository URL`: dépôt GitHub public
    - `Branch`: par exemple `test` (par défaut `main`)
    - `Compose Path`: `./compose.dokploy.yml`
    - `Save`
3. Onglet `Environment`
    - Récupérer les variables d'environnement nécessaires dans le dépôt GitHub
    - Ajouter les variables d'environnement nécessaires
    - `Save`
4. Onglet `General` > section `Deploy Settings` > `Deploy`

Si le `compose.dokploy.yml` mappe le port externe comme ceci `ports: "3005:3000"`, alors l'application sera accessible dans la VM OrbStack via [http://localhost:3005](http://localhost:3005). OrbStack redirigera automatiquement le port vers le port équivalent sur la machine hôte MacOS sur [http://localhost:3005](http://localhost:3005).
