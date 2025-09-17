# Portainer Deployment

J'ai une configuration VPS chez Hostinger avec Ubuntu 24 et Coolify d'installé.
Cette configuration n'est pas assez flexible pour mes besoins, je vais donc repartir d'une installation Ubuntu propre et installer Portainer.

Je vais documenter les étapes ici.

## Phase 0 : VPS, DNS et SMTP

-   [ ] Configurer le domaine `mondomain.com` pour qu'il pointe vers le VPS

| Type | Nom | Priorité | Contenu           | TTL   |
| ---- | --- | -------- | ----------------- | ----- |
| A    | www | 0        | my-vps-ip-address | 14400 |
| A    | @   | 0        | my-vps-ip-address | 14400 |
| A    | \*  | 0        | my-vps-ip-address | 14400 |

-   [ ] Configurer le SMTP via [UsePlunk](https://useplunk.com)

| Type  | Nom          | Priorité | Contenu      | TTL   |
| ----- | ------------ | -------- | ------------ | ----- |
| CNAME | secret_value | 0        | secret_value | 14400 |
| CNAME | secret_value | 0        | secret_value | 14400 |
| CNAME | secret_value | 0        | secret_value | 14400 |
| TXT   | plunk        | 0        | secret_value | 14400 |
| MX    | plunk        | 10       | secret_value | 14400 |

-   [ ] Créer un email `hello@mondomain.com`

## Phase 1 : Ubuntu

-   [ ] Installer Ubuntu sur le VPS depuis le panneau Hostinger

-   [ ] Configurer la connexion SSH entre le VPS et la machine locale

-   [ ] Se connecter en SSH au VPS

```bash
ssh root@my-vps-ip-address
```

-   [ ] Update système et paquets

```bash
apt update && apt upgrade -y
```

Si une fenêtre rose "Configuring openssh-server" apparaît,
sélectionner la première option "install the package maintainer's version".

-   [ ] Installer tree et vérifier la structure du VPS

```bash
apt install tree
tree -L 2 ../
```

-   [ ] Installer Docker en suivant : [Docker Ubuntu Installation](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

-   [ ] Installer Docker Engine, containerd et Docker Compose

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

-   [ ] Tester l'installation de docker

```bash
sudo docker run hello-world
```

-   [ ] Installer Lazydocker : [Lazydocker GitHub](https://github.com/jesseduffield/lazydocker)

```bash
# Installer Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
# Lien symbolique pour un accès global
ln -s /root/.local/bin/lazydocker /usr/local/bin/lazydocker
```

-   [ ] Nettoyer docker

```bash
docker stop $(docker ps -a -q)
docker rmi $(docker images -q)
docker volume rm $(docker volume ls -q)
docker network rm $(docker network ls -q)
docker system prune -a --volumes -f
```

-   [ ] Configurer docker pour s'exéctuer au démarrage du VPS

```bash
sudo systemctl enable docker
```

## Phase 2 : Portainer standalone

-   [ ] Vérifier que vous êtes bien dans `/root` avec la commande `pwd`

-   [ ] Créer un fichier `compose.yml` dans `/root`

```bash
touch compose.yml
nano compose.yml
```

-   [ ] Copier/coller le contenu du fichier `portainer/compose.vps.yml` (de ce repo) dans `compose.yml` (du vps)

-   [ ] Créer le fichier `acme.json` et lui donner les bons droits

```bash
touch acme.json
chmod 600 acme.json
```

-   [ ] Lancer la stack Traefik + Portainer

```bash
docker compose up -d
```

-   [ ] Accéder à l'interface web de Portainer via le domaine : `https://portainer.mondomain.com`

Si besoin, redémarrer le VPS pour que les certificats SSL soient bien validés.

## Phase 3 : Activer le firewall du VPS

-   [ ] Définir les règles du firewall

| Action | Protocole | Port (ou plage) | Source | Détail de la source |
| ------ | --------- | --------------- | ------ | ------------------- |
| accept | SSH       | 22              | any    | any                 |
| accept | HTTPS     | 443             | any    | any                 |
| accept | HTTP      | 80              | any    | any                 |
| drop   | any       | any             | any    | any                 |

Le SSH est nécessaire pour l'administration du VPS à distance.
Le HTTP est nécessaire pour la validation des certificats SSL via Let's Encrypt.
Le HTTPS est nécessaire pour accéder aux services web (Portainer, etc).
Toutes les autres connexions doivent être bloquées pour des raisons de sécurité.

## Phase 4 : Deployer un service web

-   [ ] Tester la stack en local avec Portainer : [Portainer en local](./portainer-local.md)
-   [ ] Créer une stack
