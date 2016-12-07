.PHONY: all setup help
.DEFAULT: all

all: setup ## build the project: setup

setup: ## install dependencies
	@echo "⚙ $@"
	@npm install -s
	# http://www.phoenixframework.org/docs/installation
	@mix local.hex
	@mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
	@cd server; mix deps.get

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
