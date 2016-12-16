SERVER_PATH := server

.PHONY: all setup deps lint test \
	server release \
	clean clean-release clean-node clean-all help
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

lint: ## mix credo
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix credo

test: ## mix test
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix test

server: deps ## run Chatty server
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix phoenix.server

release: deps ## mix release
	@echo "⚙ $@"
	@cd $(SERVER_PATH); MIX_ENV=prod mix release --env=prod

clean: ## mix clean
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix clean

clean-release: ## mix release.clean
	@echo "⚙ $@"
	@cd $(SERVER_PATH); mix release.clean

clean-node: ## remove node files
	@echo "⚙ $@"
	@npm run clean-node

clean-all: clean-release clean clean-node ## clean all

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
