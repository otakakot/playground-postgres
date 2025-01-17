SHELL := /bin/bash
include .env
export
export APP_NAME := $(basename $(notdir $(shell pwd)))

.PHONY: help
help: ## display this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: up
up: ## docker compose up with air hot reload
	@docker compose --project-name ${APP_NAME} up -d

.PHONY: down
down: ## docker compose down
	@docker compose --project-name ${APP_NAME} down --volumes

.PHONY: balus
balus: ## destroy everything about docker. (containers, images, volumes, networks.)
	@docker compose --project-name ${APP_NAME} down --rmi all --volumes

.PHONY: psql
psql:
	@docker exec -it postgres psql -U postgres

.PHONY: sql
sql: ## ex) make sql f=sql/xxx.sql
	@docker exec -it postgres psql -U postgres -f ${f}

.PHONY: atlasinspect
atlasinspect:
	@atlas schema inspect -u ${DATABASE_URL} > schema.hcl

.PHONY: atlasapply
atlasapply:
	@atlas schema apply -u ${DATABASE_URL} --to file://schema.hcl --auto-approve

.PHONY: atlasfmt
atlasfmt:
	@atlas schema fmt schema.hcl
