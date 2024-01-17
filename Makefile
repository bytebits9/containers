#define default shell
SHELL := bash

.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
# display a warning if variable is not defined
MAKEFLAGS += --warn-undefined-variables
# removes all predefines rules
MAKEFLAGS += --no-builtin-rules

OS?=$(shell uname)

ifeq ($(OS),Windows_NT)
	SHELL := bash.exe
endif

# bash colors
RED:=\033[0;31m
GREEN:=\033[0;32m
YELLOW:=\033[0;33m
NO_COLOR:=\033[0m

-include .env

# sets default goal
.DEFAULT_GOAL:=help

COMPOSE_DOCKER_CLI_BUILD?=1
DOCKER_BUILDKIT?=1
DOCKER_SERVICE_NAME?=

export COMPOSE_DOCKER_CLI_BUILD
export DOCKER_BUILDKIT

DOCKER_COMPOSE_COMMAND:= docker compose -p $(COMPOSE_PROJECT_NAME) --env-file .env

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: setup
setup: ## Initialize the .env file
	@cp env.example .env

.PHONY: start
start: ## Create and start all containers, if you want start only specify services use DOCKER_SERVICE_NAME=
	$(DOCKER_COMPOSE_COMMAND) up -d $(DOCKER_SERVICE_NAME)

.PHONY: stop
down: ## Stop and remove all containers.
	@$(DOCKER_COMPOSE_COMMAND) down

.PHONY: restart
restart: ## Restart docker containers.

.PHONY: prune
prune: ## Remove all unused containers, volumes, images.
	@docker system prune -a -f --volumes