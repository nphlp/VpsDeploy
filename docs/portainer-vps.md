# Portainer VPS Installation

## Installer Portainer

-   [ ] Cloner ce repo

-   [ ] Copier le `.env.example` en `.env` et adapter les variables d'environnement

```bash
cp .env.example .env
nano .env
```

-   [ ] Créer le fichier `acme.json` qui va stocker les certificats SSL et Let's Encrypt

```bash
make acme
```

-   [ ] Lancer la stack Traefik + Portainer

```bash
make portainer-vps
```

-   [ ] Redémarrer le VPS pour que les certificats SSL soient bien pris en compte

-   [ ] Accéder à l'interface web de Portainer via le domaine : `https://portainer.mondomain.com`

## Arrêter Portainer

```bash
make portainer-vps-stop
```
