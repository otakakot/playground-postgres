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

.PHONY: psql
psql:
	@docker exec -it postgres psql -U postgres

.PHONY: prmpsql
prmpsql:
	@docker exec -it postgres-primary psql -U postgres

.PHONY: secpsql
secpsql:
	@docker exec -it postgres-secondary psql -U postgres

.PHONY: sql
sql: ## ex) make sql f=sql/xxx.sql
	@docker exec -it postgres psql -U postgres -f ${f}

.PHONY: prmsql
prmsql: ## ex) make prmsql f=sql/xxx.sql
	@docker exec -it postgres-primary psql -U postgres -f ${f}

.PHONY: secsql
secsql: ## ex) make secsql f=sql/xxx.sql
	@docker exec -it postgres-secondary psql -U postgres -f ${f}
