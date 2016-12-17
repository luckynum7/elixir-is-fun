ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SERVER_PATH := $(ROOT_DIR)/server

.PHONY: setup deps \
	lint test server \
	release server-release \
	clean clean-node clean-all \
	all help
.DEFAULT: default

all: setup release ## build the project: setup

setup: ## install dependencies
	@echo "⚙ $@"
	@npm install -s
	@echo "http://www.phoenixframework.org/docs/installation"
	@mix local.hex --force
	@mix local.rebar --force
	@mix archive.install \
	 https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez \
	 --force
	$(MAKE) deps

deps: ## mix deps.get & compile
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix do deps.get, compile

$(SERVER_PATH)/config/prod.secret.exs: ## server/config/prod.secret.exs
	@echo "⚙ $@"
	@cd $(SERVER_PATH); $(ROOT_DIR)/commands/make-prod.secret.exs.sh

$(SERVER_PATH)/rel/config.exs: ## distillery config.exs
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix release.init

lint: ## mix credo
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix credo

test: ## mix test
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix test

server: deps ## run Chatty server
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix phoenix.server

release: deps $(SERVER_PATH)/config/prod.secret.exs $(SERVER_PATH)/rel/config.exs ## mix release
	@echo "⚙ $@"
	@cd $(SERVER_PATH); \
	 MIX_ENV=prod mix do phoenix.digest, release --env=prod

server-release: release ## server release version
	@echo "⚙ $@"
	@$(SERVER_PATH)/_build/prod/rel/chatty/bin/chatty foreground

clean: ## mix clean
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix clean

clean-node: ## remove node files
	@echo "⚙ $@"
	@npm run clean-node

clean-all: clean clean-node ## clean all

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
