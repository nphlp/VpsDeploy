###################################
#   Portainer local (prod like)   #
###################################

# TLS certificates
.PHONY: tls portainer portainer-stop

tls:
	rm -rf .dev-certs
	mkdir -p .dev-certs
	mkcert --key-file .dev-certs/local.dev.key \
	       --cert-file .dev-certs/local.dev.cert "*.local.dev"
	echo "tls:" > .dev-certs/traefik-dynamic.yml
	echo "    certificates:" >> .dev-certs/traefik-dynamic.yml
	echo "        - certFile: /etc/traefik/certs/local.dev.cert" >> .dev-certs/traefik-dynamic.yml
	echo "          keyFile: /etc/traefik/certs/local.dev.key" >> .dev-certs/traefik-dynamic.yml

portainer:
	docker compose -f compose.portainer.local.yml up -d --build

portainer-stop:
	docker compose -f compose.portainer.local.yml down
