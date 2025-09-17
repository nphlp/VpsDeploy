##############
#   Config   #
##############

.PHONY: firewall-check tls acme

tls:
	@if [ -d .dev-certs ]; then echo "Certificats TLS déjà existants dans .dev-certs/ ✅" && exit 0; fi
	@mkdir -p .dev-certs
	@mkcert --key-file .dev-certs/local.dev.key \
	       --cert-file .dev-certs/local.dev.cert "*.local.dev"
	@echo "tls:" > .dev-certs/traefik-dynamic.yml
	@echo "    certificates:" >> .dev-certs/traefik-dynamic.yml
	@echo "        - certFile: /etc/traefik/certs/local.dev.cert" >> .dev-certs/traefik-dynamic.yml
	@echo "          keyFile: /etc/traefik/certs/local.dev.key" >> .dev-certs/traefik-dynamic.yml
	@echo "Certificats TLS créés dans .dev-certs/ ✅"

acme:
	@if [ -f acme.json ]; then echo "Fichier acme.json déjà existant ✅" && exit 0; fi
	@touch acme.json
	@chmod 600 acme.json
	@echo "Fichier acme.json créé ✅"

#################
#   Portainer   #
#################

DC = COMPOSE_BAKE=true docker compose

LOCAL = compose.local.yml
VPS = compose.vps.yml

.PHONY: portainer-local portainer-local-stop portainer-vps portainer-vps-stop

# Portainer Local
portainer-local:
	$(DC) -f $(LOCAL) up -d --build

portainer-local-stop:
	$(DC) -f $(LOCAL) down

# Portainer VPS
portainer-vps:
	$(DC) -f $(VPS) up -d --build

portainer-vps-stop:
	$(DC) -f $(VPS) down

