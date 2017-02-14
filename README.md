- [Reference](#org2b8aa27)
  - [Guides](#org10dd5ec)
    - [Elxir: <http://elixir-lang.org/getting-started/introduction.html>](#org5a217b9)
    - [Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>](#orgd9358f0)
    - [GenStage](#orgbf46e32)
  - [Awesome Elixir: <https://github.com/h4cc/awesome-elixir>](#org5cf2eb8)
    - [Authentication](#orgfa0de55)
    - [Code Analysis](#orga93a0fb)
    - [Documentation](#org343148e)
    - [Framework Components](#orgc5597f6)
    - [ORM and Datamapping](#orgcf12edd)
    - [Testing](#org2110eec)
- [*How to create the server*](#org4138516)
  - [Create the server](#org33261b7)
  - [Adding prod.secret.exs.example to a git Repository](#org5eb7ff2)
    - [Add the `config/prod.secret.exs.example`](#org202d7be)
    - [Regenerate `config/prod.secret.exs`](#org859906a)
- [How to setup environment](#org8deb021)
  - [On the development machine](#org551dab2)
  - [Setup environment](#org50fe3c0)
- [How to make docker image](#orgb4b7b68)
  - [Make docker image](#org8bb7056)



<a id="org2b8aa27"></a>

# Reference


<a id="org10dd5ec"></a>

## Guides


<a id="org5a217b9"></a>

### Elxir: <http://elixir-lang.org/getting-started/introduction.html>


<a id="orgd9358f0"></a>

### Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>

-   [ ] [Umbrella projects](http://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-apps.html#umbrella-projects)
-   [ ] [Docs, tests and with](http://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html)


<a id="orgbf46e32"></a>

### GenStage

-   [ ] [Announcing GenStage](http://elixir-lang.org/blog/2016/07/14/announcing-genstage/)

GenStage is a new Elixir behaviour for exchanging events with back-pressure between Elixir processes.


<a id="org5cf2eb8"></a>

## Awesome Elixir: <https://github.com/h4cc/awesome-elixir>


<a id="orgfa0de55"></a>

### Authentication

-   [ ] [guardian](https://github.com/ueberauth/guardian) - An authentication framework for use with Elixir applications.


<a id="orga93a0fb"></a>

### Code Analysis

-   [ ] [credo](https://github.com/rrrene/credo) - A static code analysis tool with a focus on code consistency and teaching Elixir.


<a id="org343148e"></a>

### Documentation

-   [ ] [ex\_doc](https://github.com/elixir-lang/ex_doc) - ExDoc is a tool to generate documentation for your Elixir projects.


<a id="orgc5597f6"></a>

### Framework Components

-   [ ] [corsica](https://github.com/whatyouhide/corsica) - Elixir library for dealing with CORS requests.


<a id="orgcf12edd"></a>

### ORM and Datamapping

-   [ ] [ex\_sider](https://github.com/ephe-meral/ex_sider) - Elixir Map/List/Set interfaces for Redis data structures (uses Redix, but that is configurable).
-   [ ] [redix](https://github.com/whatyouhide/redix) - Superfast, pipelined, resilient Redis driver for Elixir.


<a id="org2110eec"></a>

### Testing

-   [ ] [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html) - Unit testing framework for Elixir.
-   [ ] [mock](https://github.com/jjh42/mock) - Mocking library for the Elixir language.


<a id="org4138516"></a>

# *How to create the server*


<a id="org33261b7"></a>

## Create the server

```bash
$ mix phoenix.new --no-brunch --no-ecto --no-html server --app chatty
```


<a id="org5eb7ff2"></a>

## Adding prod.secret.exs.example to a git Repository

<http://sgeos.github.io/phoenix/elixir/git/2016/07/18/phoenix-adding-prod-secret-exs-example-to-git-repository.html>


<a id="org202d7be"></a>

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


<a id="org859906a"></a>

### Regenerate `config/prod.secret.exs`

```shell
SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
sed "s|SECRET+KEY+BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example >config/prod.secret.exs
```


<a id="org8deb021"></a>

# How to setup environment


<a id="org551dab2"></a>

## On the development machine

1.  Erlang
2.  Elixir
3.  Docker
4.  Git


<a id="org50fe3c0"></a>

## Setup environment

```bash
$ make setup
```


<a id="orgb4b7b68"></a>

# How to make docker image


<a id="org8bb7056"></a>

## Make docker image

```bash
$ make image
```
