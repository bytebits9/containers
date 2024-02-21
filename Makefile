-include .env

#define default shell
SHELL := bash

.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
# display a warning if variable is not defined
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

OS?=$(shell uname)

ifeq ($(OS),Windows_NT)
	SHELL := bash.exe
endif

# bash colors
COLOR_RED:=\033[0;31m
COLOR_GREEN:=\033[0;32m
COLOR_YELLOW:=\033[0;33m
NO_COLOR:=\033[0m

# sets default goal
.DEFAULT_GOAL:=help

COMPOSE_DOCKER_CLI_BUILD?=1
DOCKER_BUILDKIT?=1

export COMPOSE_DOCKER_CLI_BUILD
export DOCKER_BUILDKIT

DOCKER_COMPOSE_COMMAND=docker compose

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\n\033[1mUsage:\033[0m\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-40s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' Makefile devops/make/*.mk

##@[Development: Setup]

.PHONY: project-init
init: ## Initialize the development environment.
	@printf "$(COLOR_YELLOW) Initialize .env file $(NO_COLOR)"
	@cp .env.example .env

##@ [Docker]
.PHONY: docker-up
docker-up: ## Start containers.
	@printf "$(COLOR_GREEN) Starting up containers for $(COMPOSE_PROJECT_NAME)...$(NO_COLOR)"
	$(DOCKER_COMPOSE_COMMAND) up -d --remove-orphans

.PHONY: docker-pull
docker-pull: # Update the containers.
	@printf "$(COLOR_GREEN) Update up containers for $(COMPOSE_PROJECT_NAME)...$(NO_COLOR)"
	$(DOCKER_COMPOSE_COMMAND) pull

.PHONY: docker-stop
docker-stop: ## Stop containers.
	@printf "$(COLOR_GREEN) Stopping containers for $(COMPOSE_PROJECT_NAME)...$(NO_COLOR)"
	$(DOCKER_COMPOSE_COMMAND) stop

.PHONY: docker-down
docker-down: ## Remove containers.
	@printf "$(COLOR_GREEN) Removing containers for $(COMPOSE_PROJECT_NAME)...$(NO_COLOR)"
	$(DOCKER_COMPOSE_COMMAND) down

.PHONY: docker-exec
docker-exec: ## Execute commands in container
	@printf "$(COLOR_GREEN) Executing commands in containers...$(NO_COLOR)"
	$(DOCKER_COMPOSE_COMMAND) exec -T php-fpm ash -c "$(filter-out $@,$(MAKECMDGOALS))"

.PHONY: docker-prune
docker-prune: ## Prune containers
	@printf "$(COLOR_GREEN) Pruning containers...$(NO_COLOR)"
	@$(DOCKER_COMPOSE_COMMAND) down -v --rmi all

