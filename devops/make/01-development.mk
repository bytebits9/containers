##@[Development: Setup]

.PHONY: init
init: ## Initialize the development environment.
	@printf "$(YELLOW) Initialize .env file $(NO_COLOR)"
	@cp ./devops/docker/.env.example ./devops/docker/.env