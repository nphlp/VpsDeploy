# VPS Configuration

## DNS du Domaine

-   [ ] Configurer le domaine `mondomain.com` pour qu'il pointe vers le VPS

| Type | Nom | Priorité | Contenu           | TTL   |
| ---- | --- | -------- | ----------------- | ----- |
| A    | www | 0        | my-vps-ip-address | 14400 |
| A    | @   | 0        | my-vps-ip-address | 14400 |
| A    | \*  | 0        | my-vps-ip-address | 14400 |

## DNS du SMTP

-   [ ] Configurer le SMTP via [UsePlunk](https://useplunk.com)

| Type  | Nom          | Priorité | Contenu      | TTL   |
| ----- | ------------ | -------- | ------------ | ----- |
| CNAME | secret_value | 0        | secret_value | 14400 |
| CNAME | secret_value | 0        | secret_value | 14400 |
| CNAME | secret_value | 0        | secret_value | 14400 |
| TXT   | plunk        | 0        | secret_value | 14400 |
| MX    | plunk        | 10       | secret_value | 14400 |

-   [ ] Créer un email `hello@mondomain.com`

## Firewall

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
