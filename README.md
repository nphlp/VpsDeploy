# Portainer Deployment

J'ai une configuration VPS chez Hostinger avec Ubuntu 24 et Coolify d'installé.
Cette configuration n'est pas assez flexible pour mes besoins, je vais donc repartir d'une installation Ubuntu propre et installer Portainer.

Je vais documenter les étapes ici.

## Phase 1 : Ubuntu

- [ ] Désactiver le FIREWALL du VPS
- [ ] Installer Ubuntu propre
- [ ] Re-configurer SSH et se connecter
- [ ] Update système + paquets
- [ ] Installer Docker

## Phase 2 : Portainer standalone

- [ ] Installer Portainer
- [ ] Créer volume + conteneur
- [ ] Accéder via vps-ip:9443 (temporaire)
- [ ] Tester avec une stack simple

## Phase 3 : Production setup

- [ ] Configurer Traefik via Portainer
- [ ] Reconfigurer Portainer derrière Traefik
- [ ] Setup DNS portainer.mondomain.com
- [ ] Ré-activer le FIREWALL du VPS pour fermer le port 9443
