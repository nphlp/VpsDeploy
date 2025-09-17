#####################
#   Nextjs server   #
#####################

.PHONY: basic basic-stop local local-stop prod prod-stop

# Build (without portainer)
basic:
	docker compose -f compose.next.basic.yml up -d --build

basic-stop:
	docker compose -f compose.next.basic.yml down

# Build (for portainer local)
local:
	docker compose -f compose.next.local.yml up -d --build

local-stop:
	docker compose -f compose.next.local.yml down

# Build (for portainer vps)
prod:
	docker compose -f compose.next.prod.yml up -d --build

prod-stop:
	docker compose -f compose.next.prod.yml down

###################################
#   Portainer local (prod like)   #
###################################

DIR = portainer/

# TLS certificates
.PHONY: tls portainer portainer-stop

tls:
	rm -rf $(DIR).dev-certs
	mkdir -p $(DIR).dev-certs
	mkcert --key-file $(DIR).dev-certs/local.dev.key \
	       --cert-file $(DIR).dev-certs/local.dev.cert "*.local.dev"
	echo "tls:" > $(DIR).dev-certs/traefik-dynamic.yml
	echo "    certificates:" >> $(DIR).dev-certs/traefik-dynamic.yml
	echo "        - certFile: /etc/traefik/certs/local.dev.cert" >> $(DIR).dev-certs/traefik-dynamic.yml
	echo "          keyFile: /etc/traefik/certs/local.dev.key" >> $(DIR).dev-certs/traefik-dynamic.yml

portainer:
	docker compose -f $(DIR)compose.portainer.local.yml up -d --build

portainer-stop:
	docker compose -f $(DIR)compose.portainer.local.yml down
