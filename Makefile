.PHONY: start stop

start:
	docker compose -f compose.local.yml up -d --build

stop:
	docker compose -f compose.local.yml down
