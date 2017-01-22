- [How to setup environment](#org75fc91d)
  - [On the development machine](#org060a237)
  - [Setup environment](#orgd4dce18)
- [How to make docker image](#org1f532f1)
  - [Make docker image](#orgf90d64c)
- [*How to create the server*](#orgf356a96)
  - [Create the server](#org4249734)
  - [Adding prod.secret.exs.example to a git Repository](#orgd6bdc6d)
    - [Add the `config/prod.secret.exs.example`](#orgf4bb17f)
    - [Regenerate `config/prod.secret.exs`](#orge4487e9)
- [Reference](#orge050787)
  - [Guides](#org8577fc5)
    - [Elxir: <http://elixir-lang.org/getting-started/introduction.html>](#orgddafaa7)
    - [Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>](#org0488a8c)
    - [GenStage](#org8706bb5)
  - [Awesome Elixir: <https://github.com/h4cc/awesome-elixir>](#org6520772)
    - [Authentication](#org11e7cec)
    - [Code Analysis](#orgba36733)
    - [Documentation](#org8cac1c1)
    - [Framework Components](#orgfeef6aa)
    - [ORM and Datamapping](#org8ed5221)
    - [Testing](#orgd3282b8)



<a id="org75fc91d"></a>

# How to setup environment


<a id="org060a237"></a>

## On the development machine

1.  Erlang
2.  Elixir
3.  Docker
4.  Git


<a id="orgd4dce18"></a>

## Setup environment

```bash
$ make setup
```


<a id="org1f532f1"></a>

# How to make docker image


<a id="orgf90d64c"></a>

## Make docker image

```bash
$ make image
```


<a id="orgf356a96"></a>

# *How to create the server*


<a id="org4249734"></a>

## Create the server

```bash
$ mix phoenix.new --no-brunch --no-ecto --no-html server --app chatty
```


<a id="orgd6bdc6d"></a>

## Adding prod.secret.exs.example to a git Repository

<http://sgeos.github.io/phoenix/elixir/git/2016/07/18/phoenix-adding-prod-secret-exs-example-to-git-repository.html>


<a id="orgf4bb17f"></a>

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


<a id="orge4487e9"></a>

### Regenerate `config/prod.secret.exs`

```shell
SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
sed "s|SECRET+KEY+BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example >config/prod.secret.exs
```


<a id="orge050787"></a>

# Reference


<a id="org8577fc5"></a>

## Guides


<a id="orgddafaa7"></a>

### Elxir: <http://elixir-lang.org/getting-started/introduction.html>


<a id="org0488a8c"></a>

### Mix, OTP, ExUnit: <http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html>

-   [ ] [Umbrella projects](http://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-apps.html#umbrella-projects)
-   [ ] [Docs, tests and with](http://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html)


<a id="org8706bb5"></a>

### GenStage

-   [ ] [Announcing GenStage](http://elixir-lang.org/blog/2016/07/14/announcing-genstage/)

GenStage is a new Elixir behaviour for exchanging events with back-pressure between Elixir processes.


<a id="org6520772"></a>

## Awesome Elixir: <https://github.com/h4cc/awesome-elixir>


<a id="org11e7cec"></a>

### Authentication

-   [ ] [guardian](https://github.com/ueberauth/guardian) - An authentication framework for use with Elixir applications.


<a id="orgba36733"></a>

### Code Analysis

-   [ ] [credo](https://github.com/rrrene/credo) - A static code analysis tool with a focus on code consistency and teaching Elixir.


<a id="org8cac1c1"></a>

### Documentation

-   [ ] [ex\_doc](https://github.com/elixir-lang/ex_doc) - ExDoc is a tool to generate documentation for your Elixir projects.


<a id="orgfeef6aa"></a>

### Framework Components

-   [ ] [corsica](https://github.com/whatyouhide/corsica) - Elixir library for dealing with CORS requests.


<a id="org8ed5221"></a>

### ORM and Datamapping

-   [ ] [ex\_sider](https://github.com/ephe-meral/ex_sider) - Elixir Map/List/Set interfaces for Redis data structures (uses Redix, but that is configurable).
-   [ ] [redix](https://github.com/whatyouhide/redix) - Superfast, pipelined, resilient Redis driver for Elixir.


<a id="orgd3282b8"></a>

### Testing

-   [ ] [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html) - Unit testing framework for Elixir.
-   [ ] [mock](https://github.com/jjh42/mock) - Mocking library for the Elixir language.
