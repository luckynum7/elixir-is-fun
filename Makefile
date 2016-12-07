SERVER_PATH := server

.PHONY: all setup deps server help
.DEFAULT: all

all: setup deps ## build the project: setup, deps

setup: ## install dependencies
	@echo "⚙ $@"
	@npm install -s
	# http://www.phoenixframework.org/docs/installation
	@mix local.hex --force
	@mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

deps: ## mix deps.*
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix deps.get
	@cd $(SERVER_PATH); mix compile

lint: ## mix credo
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix credo

test: ## mix test
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix test

server: deps ## run Chatty server
	@echo "⚙ $@"
	@mix phoenix.server

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
