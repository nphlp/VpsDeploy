# VPS Configuration

## Prérequis

- [ ] VPS
- [ ] Nom de domaine
- [ ] Service Email

## DNS du Domaine

-   [ ] Configurer le domaine `mondomain.com` pour qu'il pointe vers le VPS

| Type | Nom | Priorité | Contenu           | TTL   |
| ---- | --- | -------- | ----------------- | ----- |
| A    | www | 0        | my-vps-ip-address | 14400 |
| A    | @   | 0        | my-vps-ip-address | 14400 |
| A    | \*  | 0        | my-vps-ip-address | 14400 |

## DNS du SMTP

-   [ ] Créer un email `hello@mondomain.com`

-   [ ] Lancer la configuration automatique par Hostinger

| Type  | Nom                         | Priorité | Contenu                                        | TTL   |
| ----- | --------------------------- | -------- | ---------------------------------------------- | ----- |
| CNAME | hostingermail-c.\_domainkey | 0        | hostingermail-c.dkim.mail.hostinger.com        | 300   |
| CNAME | hostingermail-b.\_domainkey | 0        | hostingermail-b.dkim.mail.hostinger.com        | 300   |
| CNAME | hostingermail-a.\_domainkey | 0        | hostingermail-a.dkim.mail.hostinger.com        | 300   |
| CNAME | autodiscover                | 0        | autodiscover.mail.hostinger.com                | 300   |
| CNAME | autoconfig                  | 0        | autoconfig.mail.hostinger.com                  | 300   |
| TXT   | \_dmarc                     | 0        | "v=DMARC1; p=none"                             | 3600  |
| TXT   | @                           | 0        | "v=spf1 include:\_spf.mail.hostinger.com ~all" | 3600  |
| MX    | @                           | 10       | mx2.hostinger.com                              | 14400 |
| MX    | @                           | 5        | mx1.hostinger.com                              | 14400 |

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
