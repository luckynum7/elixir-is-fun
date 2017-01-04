- [How to setup environment](#org590e797)
  - [On the development machine](#org7ecf7e2)
  - [Setup environment](#orgca875ec)
- [How to make docker image](#orgc23a732)
  - [Make docker image](#orgc19d3b9)
  - [How to fix edib build errors](#org2dd4b66)
    - [[docker-elixir-dev](https://github.com/edib-tool/docker-elixir-dev)](#org4591a77)
    - [[docker-edib-tool](https://github.com/edib-tool/docker-edib-tool)](#org59ff7cf)
- [*How to create the server*](#orgaef2536)
  - [Create the server](#org84ec148)
  - [Adding prod.secret.exs.example to a git Repository](#org27cbb9a)
    - [Add the `config/prod.secret.exs.example`](#org96e9ef3)
    - [Regenerate `config/prod.secret.exs`](#org31fda95)
- [Reference](#org1e3364c)
  - [Guides](#org5500929)
    - [Elxir: <http://elixir-lang.org/getting-started/introduction.html>](#org63c1265)
    - [Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>](#orge38d8ef)
    - [GenStage](#orgf29bf2c)
  - [Awesome Elixir: <https://github.com/h4cc/awesome-elixir>](#org0276d1e)
    - [Authentication](#org7d608e5)
    - [Code Analysis](#orgfdb0978)
    - [Documentation](#org96c22e0)
    - [Framework Components](#org71f6046)
    - [ORM and Datamapping](#orgca5bd55)
    - [Testing](#orgf1400ff)
  - [Connect w/ WebRTC (better)](#org3242348)
    - [Elixir](#org41cf709)
    - [Elm](#org19aa296)
    - [Node.js](#orgc4ed306)
    - [PureScript](#orgd60b468)



<a id="org590e797"></a>

# How to setup environment


<a id="org7ecf7e2"></a>

## On the development machine

1.  Erlang
2.  Elixir
3.  Docker
4.  Git


<a id="orgca875ec"></a>

## Setup environment

```bash
$ make setup
```


<a id="orgc23a732"></a>

# How to make docker image


<a id="orgc19d3b9"></a>

## Make docker image

```bash
$ make image
```


<a id="org2dd4b66"></a>

## How to fix edib build errors


<a id="org4591a77"></a>

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


<a id="org59ff7cf"></a>

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


<a id="orgaef2536"></a>

# *How to create the server*


<a id="org84ec148"></a>

## Create the server

```bash
$ mix phoenix.new --no-brunch --no-ecto --no-html server --app chatty
```


<a id="org27cbb9a"></a>

## Adding prod.secret.exs.example to a git Repository

<http://sgeos.github.io/phoenix/elixir/git/2016/07/18/phoenix-adding-prod-secret-exs-example-to-git-repository.html>


<a id="org96e9ef3"></a>

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


<a id="org31fda95"></a>

### Regenerate `config/prod.secret.exs`

```shell
SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
sed "s|SECRET+KEY+BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example >config/prod.secret.exs
```


<a id="org1e3364c"></a>

# Reference


<a id="org5500929"></a>

## Guides


<a id="org63c1265"></a>

### Elxir: <http://elixir-lang.org/getting-started/introduction.html>


<a id="orge38d8ef"></a>

### Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>

-   [ ] [Umbrella projects](http://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-apps.html#umbrella-projects)
-   [ ] [Docs, tests and with](http://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html)


<a id="orgf29bf2c"></a>

### GenStage

-   [ ] [Announcing GenStage](http://elixir-lang.org/blog/2016/07/14/announcing-genstage/)

GenStage is a new Elixir behaviour for exchanging events with back-pressure between Elixir processes.


<a id="org0276d1e"></a>

## Awesome Elixir: <https://github.com/h4cc/awesome-elixir>


<a id="org7d608e5"></a>

### Authentication

-   [ ] [guardian](https://github.com/ueberauth/guardian) - An authentication framework for use with Elixir applications.


<a id="orgfdb0978"></a>

### Code Analysis

-   [ ] [credo](https://github.com/rrrene/credo) - A static code analysis tool with a focus on code consistency and teaching Elixir.


<a id="org96c22e0"></a>

### Documentation

-   [ ] [ex\_doc](https://github.com/elixir-lang/ex_doc) - ExDoc is a tool to generate documentation for your Elixir projects.


<a id="org71f6046"></a>

### Framework Components

-   [ ] [corsica](https://github.com/whatyouhide/corsica) - Elixir library for dealing with CORS requests.


<a id="orgca5bd55"></a>

### ORM and Datamapping

-   [ ] [ex\_sider](https://github.com/ephe-meral/ex_sider) - Elixir Map/List/Set interfaces for Redis data structures (uses Redix, but that is configurable).
-   [ ] [redix](https://github.com/whatyouhide/redix) - Superfast, pipelined, resilient Redis driver for Elixir.


<a id="orgf1400ff"></a>

### Testing

-   [ ] [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html) - Unit testing framework for Elixir.
-   [ ] [mock](https://github.com/jjh42/mock) - Mocking library for the Elixir language.


<a id="org3242348"></a>

## Connect w/ WebRTC (better)

-   [ElixirConf 2016 - WebRTC and Phoenix, when μ Seconds aren't Fast Enough by Jason Stiebs](https://youtu.be/yI5J2P9kcBQ?list=PLE7tQUdRKcyYoiEKWny0Jj72iu564bVFD)
-   <https://hpbn.co/>
-   <https://hpbn.co/webrtc/>
-   <https://webrtc.org/>
-   <https://webrtchacks.com/>


<a id="org41cf709"></a>

### Elixir

-   <https://teamch.at/>
-   [Phoenix.Presence](https://hexdocs.pm/phoenix/Phoenix.Presence.html)
-   [jeregrine/phoenix\_webrtc](https://github.com/jeregrine/phoenix_webrtc)
-   [smpallen99/webrtc\_example](https://github.com/smpallen99/webrtc_example)

1.  STUN & TURN: [processone/stun](https://github.com/processone/stun)


<a id="org19aa296"></a>

### Elm


<a id="orgc4ed306"></a>

### Node.js

-   [feross/simple-peer](https://github.com/feross/simple-peer)


<a id="orgd60b468"></a>

### PureScript

-   [puffnfresh/purescript-webrtc](https://github.com/puffnfresh/purescript-webrtc)
