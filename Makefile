.PHONY: all setup help
.DEFAULT: all

all: setup ## build the project: setup

setup: ## install dependencies
	@echo "⚙ $@"
	@npm install -s

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
