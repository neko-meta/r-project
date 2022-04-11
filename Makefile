.DEFAULT_GOAL := help

.PHONY: help
help: ## show a command list ## N/A
	@echo "Command list:"
	@printf "\033[36m%-9s\033[0m %-48s %s\n" "[Target]" "[Description]" "[Product]"
	@grep -E '^[/a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "\033[36m%-9s\033[0m %-48s %s\n", $$1, $$2, $$3}'

.PHONY: up
up: ## build and run RStudio Server in the background ## docker compose up -d --build
	@docker compose up -d --build
	@echo "💡 Access: http://localhost:8787/"

.PHONY: down
down: ## stop and remove running containers and networks ## docker compose down
	@docker compose down

.PHONY: stop
stop: ## stop running containers without deleting it ## docker compose stop
	@docker compose stop

.PHONY: start
start: ## (re-)start stopped containers ## docker compose start
	@docker compose start

.PHONY: ps
ps: ## list containers for the compose-project ## docker compose ps
	@docker compose ps

.PHONY: prune
prune: ## delete unused Docker objects ## docker system prune -f
	@docker system prune -f

.PHONY: bash
bash: ## start bash in the rstudio container ## docker compose exec rstudio /bin/bash
	@docker compose exec rstudio /bin/bash
