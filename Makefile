ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SERVER_PATH := $(ROOT_DIR)/server
PROD_SECRET := $(SERVER_PATH)/config/prod.secret.exs
REL_CONFIG := $(SERVER_PATH)/rel/config.exs

.PHONY: setup set-node set-mix deps \
	lint test server \
	release server-release \
	clean clean-node clean-all \
	all help
.DEFAULT: default

all: setup release ## build the project: setup, release

setup: ## install dependencies
	@echo "⚙ $@"
	$(MAKE) set-node
	$(MAKE) set-mix
	$(MAKE) deps


set-node: ## nodejs deps
	@echo "⚙ $@"
	@npm install -s

set-mix: ## elixir environment
	@echo "⚙ $@"
	@echo "http://www.phoenixframework.org/docs/installation"
	@mix local.hex --force
	@mix local.rebar --force
	@mix archive.install \
	 https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez \
	 --force

deps: ## mix deps.get & compile
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix do deps.get, compile

$(PROD_SECRET): ## server/config/prod.secret.exs
	@echo "⚙ $@"
	@cd $(SERVER_PATH); $(ROOT_DIR)/commands/make-prod.secret.exs.sh

$(REL_CONFIG): ## distillery config.exs
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix release.init

lint: ## mix credo
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix credo

test: ## mix test
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix test

server: ## run Chatty server
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix phoenix.server

release: $(PROD_SECRET) $(REL_CONFIG) ## mix release
	@echo "⚙ $@"
	@cd $(SERVER_PATH); \
	 MIX_ENV=prod mix do phoenix.digest, release --env=prod

server-release: ## server release version
	@echo "⚙ $@"
	@PORT=8080 $(SERVER_PATH)/_build/prod/rel/chatty/bin/chatty foreground

clean: ## mix clean
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix clean

clean-node: ## remove node files
	@echo "⚙ $@"
	@npm run clean-node

clean-all: clean clean-node ## clean all

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
