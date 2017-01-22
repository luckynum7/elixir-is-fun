ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SERVER_PATH := $(ROOT_DIR)/server
PROD_SECRET := $(SERVER_PATH)/config/prod.secret.exs
REL_CONFIG := $(SERVER_PATH)/rel/config.exs
APP_PATH := $(SERVER_PATH)/_build/prod/rel/chatty
CLIENT_PATH := $(ROOT_DIR)/client

.PHONY: setup setup-mix deps setup-elm \
	lint test server \
	release serve-release \
	image serve-image\
	clean clean-all \
	all help
.DEFAULT: default

all: setup image serve-image ## build the project: setup, image, serve-image

setup: ## install dependencies
	@echo "⚙ $@"
	@$(MAKE) setup-mix
	@$(MAKE) deps
	# @$(MAKE) setup-elm

setup-mix: ## elixir environment
	@echo "⚙ $@"
	@echo "http://www.phoenixframework.org/docs/installation"
	@mix local.hex --force
	@mix local.rebar --force
	@mix archive.install \
	 https://github.com/phoenixframework/archives/raw/master/phoenix_new-1.2.1.ez \
	 --force
	@mix archive.install https://git.io/edib-0.10.0.ez --force

deps: ## mix deps.get & compile
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix do deps.get, compile

setup-elm: ## elm environment
	@echo "⚙ $@"
	@cd $(CLIENT_PATH); elm make

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

serve-release: ## server release version
	@echo "⚙ $@"
	@PORT=4000 $(APP_PATH)/bin/chatty foreground

image: $(PROD_SECRET) $(REL_CONFIG) ## mix edib, build docker image
	@echo "⚙ $@"
	@cd $(SERVER_PATH); \
	 MIX_ENV=prod mix edib

serve-image: ## serve docker image
	@echo "⚙ $@"
	@docker run --rm -e "PORT=4000" -p 4000:4000 local/chatty:latest

clean: ## mix clean
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix clean

clean-all: clean ## clean all

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
