# Cloudflare

## Reverse proxy et CDN

### L'objectif

Configurer Cloudflare en tant que reverse proxy et CDN pour une application web.

Le reverse proxy permet de protéger des attaques directes sur le VPS. Le CDN permet d'améliorer les performances de délivrabilité des contenus statiques.

Cas d'utilisation typique :

1. `USER REQUEST`
2. `my-domain.com`
3. `DNS (Hostinger)`
4. `195.200.xx.xxx (VPS Hostinger)`
5. `Dokploy/Traefik`
6. `Container Docker (application web)`

Cas d'utilisation avec Cloudflare :

1. `USER REQUEST`
2. `my-domain.com`
3. **`DNS (Cloudflare)`** _(changes)_
4. **`Cloudflare CDN/Proxy`** _(new)_
5. `195.200.xx.xxx (VPS Hostinger)`
6. `Dokploy/Traefik`
7. `Container Docker (application web)`

### Configuration DNS par Hostinger (avant Cloudflare)

1. Partie `nameservers`

C'est le service DNS choisi pour gérer les `enregistrements DNS` du `domaine`.

| Type | Nom           | Priorité | Contenu             | TTL   |
| ---- | ------------- | -------- | ------------------- | ----- |
| NS   | mondomain.com | 0        | ns1.dns-parking.com | 86400 |
| NS   | mondomain.com | 0        | ns2.dns-parking.com | 86400 |

2. Partie `my-domain.com`

C'est la configuration DNS des services `WEB` : mon `domaine.com` pointe vers l'`IP du VPS`.

| Type | Nom | Priorité | Contenu           | TTL   |
| ---- | --- | -------- | ----------------- | ----- |
| A    | www | 0        | my-vps-ip-address | 14400 |
| A    | @   | 0        | my-vps-ip-address | 14400 |
| A    | \*  | 0        | my-vps-ip-address | 14400 |

3. Partie `SMTP`

C'est la configuration DNS des services `MAIL` : mon `email@domain.com` pointe vers le `service email Hostinger`.

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

### Créer une configuration Cloudflare Proxy et DNS

-   [ ] Créer un compte Cloudflare
-   [ ] Aller dans le Dashboard > Accueil du compte > Onglet `Domaines`
-   [ ] Formulaire "Améliorer la vitesse et la sécurité de votre site web"

    1. Entrer le domaine `my-domain.com`
    2. Cocher `Analyse rapide des enregistrements DNS (recommandé)`
    3. Sélectionner un mode de controle des BOT IA
    4. "Continuer"

-   [ ] Choisir le plan gratuit
-   [ ] Configurer les enregistrements DNS comme suit :

    1. Activer le Proxy sur les enregistrements `WEB`
    2. Désactiver le Proxy sur les enregistrements `MAIL`, basculement en DNS uniquement
    3. Laisser les `NAMESERVERS` (`NS`) du tableau, ils seront obsolètes après le changement de `nameservers` chez Hostinger
    4. "Passer à l'activation"

| Gestion    | Proxy Cloudflare                 | Type  | Nom                         | Priorité | Contenu                                        | TTL   |
| ---------- | -------------------------------- | ----- | --------------------------- | -------- | ---------------------------------------------- | ----- |
| WEB        | Proxy activé                     | A     | www                         | 0        | my-vps-ip-address                              | 14400 |
| WEB        | Proxy activé                     | A     | @                           | 0        | my-vps-ip-address                              | 14400 |
| WEB        | Proxy activé                     | A     | \*                          | 0        | my-vps-ip-address                              | 14400 |
| MAIL       | Proxy désactivé (DNS Uniquement) | CNAME | hostingermail-c.\_domainkey | 0        | hostingermail-c.dkim.mail.hostinger.com        | 300   |
| MAIL       | Proxy désactivé (DNS Uniquement) | CNAME | hostingermail-b.\_domainkey | 0        | hostingermail-b.dkim.mail.hostinger.com        | 300   |
| MAIL       | Proxy désactivé (DNS Uniquement) | CNAME | hostingermail-a.\_domainkey | 0        | hostingermail-a.dkim.mail.hostinger.com        | 300   |
| MAIL       | Proxy désactivé (DNS Uniquement) | CNAME | autodiscover                | 0        | autodiscover.mail.hostinger.com                | 300   |
| MAIL       | Proxy désactivé (DNS Uniquement) | CNAME | autoconfig                  | 0        | autoconfig.mail.hostinger.com                  | 300   |
| MAIL       | DNS Uniquement                   | MX    | @                           | 10       | mx2.hostinger.com                              | 14400 |
| MAIL       | DNS Uniquement                   | MX    | @                           | 5        | mx1.hostinger.com                              | 14400 |
| NAMESERVER | Ne rien faire ou à supprimer     | NS    | mondomain.com               | 0        | ns1.dns-parking.com -> boyd.ns.cloudflare.com  | 86400 |
| NAMESERVER | Ne rien faire ou à supprimer     | NS    | mondomain.com               | 0        | ns2.dns-parking.com -> val.ns.cloudflare.com   | 86400 |
| MAIL       | DNS Uniquement                   | TXT   | \_dmarc                     | 0        | "v=DMARC1; p=none"                             | 3600  |
| MAIL       | DNS Uniquement                   | TXT   | @                           | 0        | "v=spf1 include:\_spf.mail.hostinger.com ~all" | 3600  |

-   [ ] Se rendre dans le `hPanel` d'Hostinger > `Domaines` > `Serveurs de noms`

    1. Bouton "Changer les serveurs de noms"
    2. Cocher `Changer les serveurs de noms`
    3. Remplacer le `ns1.dns-parking.com` et `ns2.dns-parking.com` par ceux fournis par Cloudflare

-   [ ] Attendre la confirmation de propagation des DNS (peut prendre jusqu'à 24h) par email

## Stockage d'objets R2
