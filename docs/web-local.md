# Web Local Deploy

## Via Portainer UI

Cette méthode permet à Portainer de tracker le repo Git, les fonctionnalités de Portainer sont toutes disponibles.

- [ ] Lancer Portainer en local avec `make portainer`
- [ ] Accéder à l'interface Portainer via : [https://portainer.local.dev](https://portainer.local.dev)
- [ ] Sélectionner l'environnement `primary`
- [ ] Aller dans `Stacks` -> `Add stack`
- [ ] Nommer la stack `nextjs-example`
- [ ] Ajouter un repository Git `https://github.com/mon-compte/mon-repo.git`
- [ ] Choisir la référence cible `refs/heads/main`
- [ ] Choisir le `compose.yml` cible
- [ ] Ajouter les variables d'environnement
- [ ] Déployer

## Via CLI

Cette méthode ne permet pas à Portainer de tracker le repo Git, les fonctionnalités de Portainer sont limitées.

- [ ] Se rendre dans le dossier du projet à déployer (ex: `~/Code/NextjsDeploy/`)
- [ ] Lancer la stack en local avec `make local`
- [ ] Accéder à l'interface Portainer via : [https://portainer.local.dev](https://portainer.local.dev)
- [ ] Visualiser la stack dans l'environnement `primary`
- [ ] Arrêter la stack en local avec `make local-stop`
