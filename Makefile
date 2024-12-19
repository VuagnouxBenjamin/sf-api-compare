.PHONY: help install start stop build cc

# Variables
DOCKER = docker-compose
CONSOLE = $(DOCKER) exec php bin/console

help: ## Affiche l'aide
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

install: ## Installe les dépendances du projet
	$(DOCKER) run --rm php composer install

start: ## Démarre les conteneurs Docker
	$(DOCKER) up -d --remove-orphans

stop: ## Arrête les conteneurs Docker
	$(DOCKER) down

build: ## Reconstruit les images Docker
	$(DOCKER) build --no-cache

cc: ## Vide le cache Symfony
	$(CONSOLE) cache:clear

connect: ## Se connecte au container PHP
	$(DOCKER) exec -it php bash
