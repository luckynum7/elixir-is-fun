- [How to setup environment](#orgd005f3e)
  - [On the development machine](#org76cdc34)
  - [Setup environment](#org3c4ddba)
- [How to make docker image](#orge93a945)
  - [Make docker image](#org421570f)
  - [How to fix edib build errors](#org9314433)
    - [[docker-elixir-dev](https://github.com/edib-tool/docker-elixir-dev)](#org5343673)
    - [[docker-edib-tool](https://github.com/edib-tool/docker-edib-tool)](#orgd092b29)
- [*How to create the server*](#org8437335)
  - [Create the server](#orgdb69288)
  - [Adding prod.secret.exs.example to a git Repository](#org0926f65)
    - [Add the `config/prod.secret.exs.example`](#org7c0548f)
    - [Regenerate `config/prod.secret.exs`](#org1a7fe72)
- [Reference](#org54b5d43)
  - [Guides](#org5a45b3d)
    - [Elxir: <http://elixir-lang.org/getting-started/introduction.html>](#org69c62da)
    - [Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>](#org9b7049c)
    - [GenStage](#org3a40509)
  - [Awesome Elixir: <https://github.com/h4cc/awesome-elixir>](#org8756efd)
    - [Authentication](#org24fc0fd)
    - [Code Analysis](#org696414b)
    - [Documentation](#org4d5a41e)
    - [Framework Components](#orgdb8f6dd)
    - [ORM and Datamapping](#org738a364)
    - [Testing](#orgab34f5f)
  - [Connect w/ WebRTC (better)](#org235b2a3)
    - [Elixir](#orgedc7306)
    - [Elm](#orgcf2de3d)
    - [Node.js](#org00585e1)
    - [PureScript](#orgf44c426)



<a id="orgd005f3e"></a>

# How to setup environment


<a id="org76cdc34"></a>

## On the development machine

1.  Erlang
2.  Elixir
3.  Docker
4.  Git


<a id="org3c4ddba"></a>

## Setup environment

```bash
$ make setup
```


<a id="orge93a945"></a>

# How to make docker image


<a id="org421570f"></a>

## Make docker image

```bash
$ make image
```


<a id="org9314433"></a>

## How to fix edib build errors


<a id="org5343673"></a>

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


<a id="orgd092b29"></a>

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


<a id="org8437335"></a>

# *How to create the server*


<a id="orgdb69288"></a>

## Create the server

```bash
$ mix phoenix.new --no-brunch --no-ecto --no-html server --app chatty
```


<a id="org0926f65"></a>

## Adding prod.secret.exs.example to a git Repository

<http://sgeos.github.io/phoenix/elixir/git/2016/07/18/phoenix-adding-prod-secret-exs-example-to-git-repository.html>


<a id="org7c0548f"></a>

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


<a id="org1a7fe72"></a>

### Regenerate `config/prod.secret.exs`

```shell
SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
sed "s|SECRET+KEY+BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example >config/prod.secret.exs
```


<a id="org54b5d43"></a>

# Reference


<a id="org5a45b3d"></a>

## Guides


<a id="org69c62da"></a>

### Elxir: <http://elixir-lang.org/getting-started/introduction.html>


<a id="org9b7049c"></a>

### Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>

-   [ ] [Umbrella projects](http://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-apps.html#umbrella-projects)
-   [ ] [Docs, tests and with](http://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html)


<a id="org3a40509"></a>

### GenStage

-   [ ] [Announcing GenStage](http://elixir-lang.org/blog/2016/07/14/announcing-genstage/)

GenStage is a new Elixir behaviour for exchanging events with back-pressure between Elixir processes.


<a id="org8756efd"></a>

## Awesome Elixir: <https://github.com/h4cc/awesome-elixir>


<a id="org24fc0fd"></a>

### Authentication

-   [ ] [guardian](https://github.com/ueberauth/guardian) - An authentication framework for use with Elixir applications.


<a id="org696414b"></a>

### Code Analysis

-   [ ] [credo](https://github.com/rrrene/credo) - A static code analysis tool with a focus on code consistency and teaching Elixir.


<a id="org4d5a41e"></a>

### Documentation

-   [ ] [ex<sub>doc</sub>](https://github.com/elixir-lang/ex_doc) - ExDoc is a tool to generate documentation for your Elixir projects.


<a id="orgdb8f6dd"></a>

### Framework Components

-   [ ] [corsica](https://github.com/whatyouhide/corsica) - Elixir library for dealing with CORS requests.


<a id="org738a364"></a>

### ORM and Datamapping

-   [ ] [ex<sub>sider</sub>](https://github.com/ephe-meral/ex_sider) - Elixir Map/List/Set interfaces for Redis data structures (uses Redix, but that is configurable).
-   [ ] [redix](https://github.com/whatyouhide/redix) - Superfast, pipelined, resilient Redis driver for Elixir.


<a id="orgab34f5f"></a>

### Testing

-   [ ] [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html) - Unit testing framework for Elixir.
-   [ ] [mock](https://github.com/jjh42/mock) - Mocking library for the Elixir language.


<a id="org235b2a3"></a>

## Connect w/ WebRTC (better)

-   [ElixirConf 2016 - WebRTC and Phoenix, when μ Seconds aren't Fast Enough by Jason Stiebs](https://youtu.be/yI5J2P9kcBQ?list=PLE7tQUdRKcyYoiEKWny0Jj72iu564bVFD)
-   <https://hpbn.co/>
-   <https://hpbn.co/webrtc/>
-   <https://webrtc.org/>
-   <https://webrtchacks.com/>


<a id="orgedc7306"></a>

### Elixir

-   <https://teamch.at/>
-   [Phoenix.Presence](https://hexdocs.pm/phoenix/Phoenix.Presence.html)
-   [jeregrine/phoenix<sub>webrtc</sub>](https://github.com/jeregrine/phoenix_webrtc)
-   [smpallen99/webrtc<sub>example</sub>](https://github.com/smpallen99/webrtc_example)

1.  STUN & TURN: [processone/stun](https://github.com/processone/stun)


<a id="orgcf2de3d"></a>

### Elm


<a id="org00585e1"></a>

### Node.js

-   [feross/simple-peer](https://github.com/feross/simple-peer)


<a id="orgf44c426"></a>

### PureScript

-   [puffnfresh/purescript-webrtc](https://github.com/puffnfresh/purescript-webrtc)
