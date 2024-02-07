COMPOSE_DOCKER_CLI_BUILD?=1
DOCKER_BUILDKIT?=1

export COMPOSE_DOCKER_CLI_BUILD
export DOCKER_BUILDKIT

DOCKER_DIR:=./devops/docker/
DOCKER_ENV_FILE:=$(DOCKER_DIR)/.env
DOCKER_COMPOSE_DIR:=./devops/docker/docker-compose
DOCKER_COMPOSE_FILES:=-f $(DOCKER_COMPOSE_DIR)/docker-compose.yml
DOCKER_COMPOSE_COMMAND:=docker compose -p $(COMPOSE_PROJECT_NAME) --env-file=${DOCKER_ENV_FILE}
DOCKER_COMPOSE:=$(DOCKER_COMPOSE_COMMAND) $(DOCKER_COMPOSE_FILES)

##@ [Docker]
.PHONY: docker-up
docker-up: ## Start containers.
	@printf "$(COLOR_GREEN) Starting up containers ...$(NO_COLOR)"
	$(DOCKER_COMPOSE) up -d --remove-orphans

.PHONY: docker-stop
docker-stop: ## Stop containers
	@printf "$(COLOR_GREEN) Stopping containers ...$(NO_COLOR)"
	$(DOCKER_COMPOSE) stop

.PHONY: docker-exec
docker-exec: ## Execute commands in container
	@printf "$(COLOR_GREEN) Executing commands in containers...$(NO_COLOR)"
	$(DOCKER_COMPOSE) exec -T php-fpm ash -c "$(filter-out $@,$(MAKECMDGOALS))"

.PHONY: docker-prune
docker-prune: ## Prune containers
	@printf "$(COLOR_GREEN) Pruning containers...$(NO_COLOR)"
	@docker system prune -a -f --volumes
