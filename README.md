- [How to setup environment](#org557a66d)
  - [On the development machine](#orgec62106)
  - [Setup environment](#org1cfa4cb)
- [How to make docker image](#org2b87820)
  - [Make docker image](#org2a64cbc)
  - [How to fix edib build errors](#orgfec6561)
    - [[docker-elixir-dev](https://github.com/edib-tool/docker-elixir-dev)](#orge3b7291)
    - [[docker-edib-tool](https://github.com/edib-tool/docker-edib-tool)](#org5f84f92)
- [*How to create the server*](#org0eeb870)
  - [Create the server](#orge0be22a)
  - [Adding prod.secret.exs.example to a git Repository](#orgaf49729)
    - [Add the `config/prod.secret.exs.example`](#org8a552dc)
    - [Regenerate `config/prod.secret.exs`](#orgc442473)
- [Reference](#org11b5933)
  - [Guides](#org41031cf)
    - [Elxir: <http://elixir-lang.org/getting-started/introduction.html>](#org175d044)
    - [Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>](#orge5bceb5)
    - [GenStage](#org3e92fd0)
  - [Awesome Elixir: <https://github.com/h4cc/awesome-elixir>](#org91462dd)
    - [Authentication](#org016a50a)
    - [Code Analysis](#orgc336d44)
    - [Documentation](#org37a2cc1)
    - [Framework Components](#org18237ec)
    - [ORM and Datamapping](#orgbd52e19)
    - [Testing](#org7f858fe)



<a id="org557a66d"></a>

# How to setup environment


<a id="orgec62106"></a>

## On the development machine

1.  Erlang
2.  Elixir
3.  Docker
4.  Git


<a id="org1cfa4cb"></a>

## Setup environment

```bash
$ make setup
```


<a id="org2b87820"></a>

# How to make docker image


<a id="org2a64cbc"></a>

## Make docker image

```bash
$ make image
```


<a id="orgfec6561"></a>

## How to fix edib build errors


<a id="orge3b7291"></a>

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


<a id="org5f84f92"></a>

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


<a id="org0eeb870"></a>

# *How to create the server*


<a id="orge0be22a"></a>

## Create the server

```bash
$ mix phoenix.new --no-brunch --no-ecto --no-html server --app chatty
```


<a id="orgaf49729"></a>

## Adding prod.secret.exs.example to a git Repository

<http://sgeos.github.io/phoenix/elixir/git/2016/07/18/phoenix-adding-prod-secret-exs-example-to-git-repository.html>


<a id="org8a552dc"></a>

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


<a id="orgc442473"></a>

### Regenerate `config/prod.secret.exs`

```shell
SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
sed "s|SECRET+KEY+BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example >config/prod.secret.exs
```


<a id="org11b5933"></a>

# Reference


<a id="org41031cf"></a>

## Guides


<a id="org175d044"></a>

### Elxir: <http://elixir-lang.org/getting-started/introduction.html>


<a id="orge5bceb5"></a>

### Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>

-   [ ] [Umbrella projects](http://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-apps.html#umbrella-projects)
-   [ ] [Docs, tests and with](http://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html)


<a id="org3e92fd0"></a>

### GenStage

-   [ ] [Announcing GenStage](http://elixir-lang.org/blog/2016/07/14/announcing-genstage/)

GenStage is a new Elixir behaviour for exchanging events with back-pressure between Elixir processes.


<a id="org91462dd"></a>

## Awesome Elixir: <https://github.com/h4cc/awesome-elixir>


<a id="org016a50a"></a>

### Authentication

-   [ ] [guardian](https://github.com/ueberauth/guardian) - An authentication framework for use with Elixir applications.


<a id="orgc336d44"></a>

### Code Analysis

-   [ ] [credo](https://github.com/rrrene/credo) - A static code analysis tool with a focus on code consistency and teaching Elixir.


<a id="org37a2cc1"></a>

### Documentation

-   [ ] [ex\_doc](https://github.com/elixir-lang/ex_doc) - ExDoc is a tool to generate documentation for your Elixir projects.


<a id="org18237ec"></a>

### Framework Components

-   [ ] [corsica](https://github.com/whatyouhide/corsica) - Elixir library for dealing with CORS requests.


<a id="orgbd52e19"></a>

### ORM and Datamapping

-   [ ] [ex\_sider](https://github.com/ephe-meral/ex_sider) - Elixir Map/List/Set interfaces for Redis data structures (uses Redix, but that is configurable).
-   [ ] [redix](https://github.com/whatyouhide/redix) - Superfast, pipelined, resilient Redis driver for Elixir.


<a id="org7f858fe"></a>

### Testing

-   [ ] [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html) - Unit testing framework for Elixir.
-   [ ] [mock](https://github.com/jjh42/mock) - Mocking library for the Elixir language.
