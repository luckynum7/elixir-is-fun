- [How to setup environment](#org7e75d98)
  - [On the development machine](#orgcbc32e1)
  - [Setup environment](#org91bb972)
- [How to make docker image](#org51689e7)
  - [Make docker image](#org4eccac4)
  - [How to fix edib build errors](#orgf213fea)
    - [[docker-elixir-dev](https://github.com/edib-tool/docker-elixir-dev)](#org76eb4ce)
    - [[docker-edib-tool](https://github.com/edib-tool/docker-edib-tool)](#org325917d)
- [*How to create the server*](#orgbd4eae7)
  - [Create the server](#org3ea173e)
  - [Adding prod.secret.exs.example to a git Repository](#orgbc716d8)
    - [Add the `config/prod.secret.exs.example`](#org914f52c)
    - [Regenerate `config/prod.secret.exs`](#org40fca80)
- [Reference](#orgbd6a5cf)
  - [Guides](#orgb3fd98c)
    - [Elxir: <http://elixir-lang.org/getting-started/introduction.html>](#orgb11e9b2)
    - [Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>](#org993185a)
    - [GenStage](#org668bc80)
  - [Awesome Elixir: <https://github.com/h4cc/awesome-elixir>](#orgdcf8b7e)
    - [Authentication](#org71aeab4)
    - [Code Analysis](#orgceeeac6)
    - [Documentation](#orge20ae0d)
    - [Framework Components](#org1bc294e)
    - [ORM and Datamapping](#org494c517)
    - [Testing](#orgda9c98b)



<a id="org7e75d98"></a>

# How to setup environment


<a id="orgcbc32e1"></a>

## On the development machine

1.  Erlang
2.  Elixir
3.  Docker
4.  Git


<a id="org91bb972"></a>

## Setup environment

```bash
$ make setup
```


<a id="org51689e7"></a>

# How to make docker image


<a id="org4eccac4"></a>

## Make docker image

```bash
$ make image
```


<a id="orgf213fea"></a>

## How to fix edib build errors


<a id="org76eb4ce"></a>

### [docker-elixir-dev](https://github.com/edib-tool/docker-elixir-dev)

```diff
diff --git a/Dockerfile b/Dockerfile
index 15dcbec..2ae8f21 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -3,7 +3,7 @@ MAINTAINER Christoph Grabo <edib@markentier.com>

 *RUN apk --update add 'elixir<1.4.0' && rm -rf /var/cache/apk/*

-ENV ELIXIR_VERSION 1.3.3
+ENV ELIXIR_VERSION 1.3.4

 RUN curl -sSL https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip \
     -o Precompiled.zip && \
```

```bash
$ docker build -t edib/elixir-phoenix-dev:1.3 .
```


<a id="org325917d"></a>

### [docker-edib-tool](https://github.com/edib-tool/docker-edib-tool)

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
diff --git a/tools/libdeps.exs b/tools/libdeps.exs
index 2399b70..4b93518 100755
--- a/tools/libdeps.exs
+++ b/tools/libdeps.exs
@@ -1,6 +1,6 @@
 *!/usr/bin/env elixir
 defmodule Libdeps do
-  @relpath "app/rel"
+  @relpath "app/_build"
   @lddpath_regex ~r/\/(lib|usr\/lib)[^ ]+/

   def all_files do
```

```bash
$ docker build -t edib/edib-tool:1.4.0 .
```


<a id="orgbd4eae7"></a>

# *How to create the server*


<a id="org3ea173e"></a>

## Create the server

```bash
$ mix phoenix.new --no-brunch --no-ecto --no-html server --app chatty
```


<a id="orgbc716d8"></a>

## Adding prod.secret.exs.example to a git Repository

<http://sgeos.github.io/phoenix/elixir/git/2016/07/18/phoenix-adding-prod-secret-exs-example-to-git-repository.html>


<a id="org914f52c"></a>

### Add the `config/prod.secret.exs.example`

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


<a id="org40fca80"></a>

### Regenerate `config/prod.secret.exs`

```shell
SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
sed "s|SECRET+KEY+BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example >config/prod.secret.exs
```


<a id="orgbd6a5cf"></a>

# Reference


<a id="orgb3fd98c"></a>

## Guides


<a id="orgb11e9b2"></a>

### Elxir: <http://elixir-lang.org/getting-started/introduction.html>


<a id="org993185a"></a>

### Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>

-   [ ] [Umbrella projects](http://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-apps.html#umbrella-projects)
-   [ ] [Docs, tests and with](http://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html)


<a id="org668bc80"></a>

### GenStage

-   [ ] [Announcing GenStage](http://elixir-lang.org/blog/2016/07/14/announcing-genstage/)

GenStage is a new Elixir behaviour for exchanging events with back-pressure between Elixir processes.


<a id="orgdcf8b7e"></a>

## Awesome Elixir: <https://github.com/h4cc/awesome-elixir>


<a id="org71aeab4"></a>

### Authentication

-   [ ] [guardian](https://github.com/ueberauth/guardian) - An authentication framework for use with Elixir applications.


<a id="orgceeeac6"></a>

### Code Analysis

-   [ ] [credo](https://github.com/rrrene/credo) - A static code analysis tool with a focus on code consistency and teaching Elixir.


<a id="orge20ae0d"></a>

### Documentation

-   [ ] [ex<sub>doc</sub>](https://github.com/elixir-lang/ex_doc) - ExDoc is a tool to generate documentation for your Elixir projects.


<a id="org1bc294e"></a>

### Framework Components

-   [ ] [corsica](https://github.com/whatyouhide/corsica) - Elixir library for dealing with CORS requests.


<a id="org494c517"></a>

### ORM and Datamapping

-   [ ] [ex<sub>sider</sub>](https://github.com/ephe-meral/ex_sider) - Elixir Map/List/Set interfaces for Redis data structures (uses Redix, but that is configurable).
-   [ ] [redix](https://github.com/whatyouhide/redix) - Superfast, pipelined, resilient Redis driver for Elixir.


<a id="orgda9c98b"></a>

### Testing

-   [ ] [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html) - Unit testing framework for Elixir.
-   [ ] [mock](https://github.com/jjh42/mock) - Mocking library for the Elixir language.
