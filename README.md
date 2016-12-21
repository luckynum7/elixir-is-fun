# elixir is fun

## TODOs
- [x] phoenix framework
- [x] docker
- [ ] redis

## How to setup

### On the development machine
1. Erlang
2. Elixir
3. Docker
4. Git

### Setup environment

``` bash
$ make setup
```

### How to fix edib build errors

1.https://github.com/edib-tool/docker-base-erlang

``` bash
$ docker build -t edib/base-erlang:19 .
```

2.https://github.com/edib-tool/docker-elixir-dev

``` bash
$ docker build -t edib/elixir-phoenix-dev:1.3 .
```

3.https://github.com/edib-tool/docker-edib-tool

```diff
diff --git a/edib/shared.mk b/edib/shared.mk
index 1924937..694fd58 100644
--- a/edib/shared.mk
+++ b/edib/shared.mk
@@ -10,7 +10,7 @@ APP_VER        = $(shell $(APPINFO_RUNNER) version)
 
 MIX_ENV       ?= prod
 RELEASE        = releases/$(APP_VER)/$(APP_NAME).tar.gz
-RELEASE_PATH   = $(APP_DIR)/rel/$(APP_NAME)
+RELEASE_PATH   = $(APP_DIR)/_build/$(MIX_ENV)/rel/$(APP_NAME)
 RELEASE_FILE   = $(RELEASE_PATH)/$(RELEASE)
 
 STAGE_DIR      = /stage
```

``` bash
$ docker build -t edib/edib-tool:1.4.0 .
```

## How to generate the app
1.generate the app

```bash
$ mix phoenix.new --no-brunch --no-ecto --no-html server --app chatty
```

2.the `prod.secret.exs.example`

[Phoenix/Elixir, Adding prod.secret.exs.example to a git Repository](
http://sgeos.github.io/phoenix/elixir/git/2016/07/18/
phoenix-adding-prod-secret-exs-example-to-git-repository.html)

```bash
$ cp server/config/prod.secret.exs server/config/prod.secret.exs.example
```

```elixir
# Regenerate config/prod.secret.exs with the following commands
#   $ SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
#   $ sed "s|SECRET+KEY+BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example >config/prod.secret.exs
config :memo_api, MemoApi.Endpoint,
  secret_key_base: "SECRET+KEY+BASE"
```

3.regenerate the `prod.secret.exs`

```bash
$ SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
$ sed "s|SECRET+KEY+BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example >config/prod.secret.exs
```
