# Portainer VPS Installation

## Avec git

-   [ ] Vérifier que vous êtes bien dans `/root` avec la commande `pwd`

-   [ ] Cloner ce repo

-   [ ] Copier le `.env.example` en `.env` et adapter les variables d'environnement

```bash
cp .env.example .env
nano .env
```

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
