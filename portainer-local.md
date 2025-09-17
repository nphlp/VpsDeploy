# Portainer & Traefik (local)

## Concept

Le but est de reproduire la configuration **Portainer/Traefik du VPS en local** afin de tester les stacks en local avant la production.

Les composes `Portainer/Traefik` sont placées dans le répertoire `portainer/`.

- `compose.portainer.yml` : configuration Portainer/Traefik -> **en local**
- `compose.vps.yml` : configuration Portainer/Traefik -> **sur le VPS**

La stack Portainer/Traefik est indépendante (standalone) et la stack web est déployée via Portainer.

Les composes `Nextjs` sont placées dans le répertoire `web/`.

- `compose.local.yml` : configuration Nextjs en local -> **hors Portainer**
- `compose.prod.yml` : configuration Nextjs en production -> **via Portainer**

## Guide d'installation

- [ ] Générer des certificats SSL auto-signés pour le domaine local

```bash
make tls
```

- [ ] Ajouter les entrées dans le fichier hosts

```bash
# Editer le fichier hosts
nano /etc/hosts

# Inserer les lignes suivantes
127.0.0.1 front.local.dev
127.0.0.1 traefik.local.dev
127.0.0.1 edge.local.dev
127.0.0.1 portainer.local.dev
```

- [ ] Lancer la stack Portainer/Traefik

```bash
make portainer
```

- [ ] Accéder à l'interface Portainer via : [https://portainer.local.dev](https://portainer.local.dev)

## Tester une stack web


