# Infisical

Gestion des secrets et des variables d'environnement avec Infisical.

## Self-host on Dokploy

- [ ] Créer un nouveau projet Dokploy
- [ ] Créer un nouveau Service > Template > Infisical

- [ ] Modifier le domaine

    1. Onglet Domains > Modifier
    2. Changer le domaine par défaut `infisical-xxx-.traefik.me` par `infisical.mondomain.com`
    3. Activer le HTTPS avec le provider `Let's Encrypt`
    4. "Update"

- [ ] Modifier la variable d'environnement

    1. Onglet Environment Variables > Modifier
    2. Changer la variable `SITE_URL` `http://infisical-xxx-.traefik.me:8080` par `https://infisical.mondomain.com:8080`
    3. "Save"

- [ ] Deployer le service

