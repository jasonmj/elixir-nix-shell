## About

This is a minimal starter repo for using nix-shell to run an Elixir Phoenix project with PostGreSQL. The environment variables needed to bootstrap the PostGreSQL database are included in `.envrc`, which is not ignored by `.gitignore`. However, in a real project, you will likely want to keep the contents of this file secret by including it in `.gitignore`.


## Prerequisites

Make sure you have already installed [nix package manager](https://nixos.org/manual/nix/stable/introduction.html) and configured the `nixpkgs` channel as with [nix-channels](https://nixos.wiki/wiki/Nix_channels).


## Getting Started

Run `nix-shell` from the repo root to start the shell environment. If you're running it for the first time, a PostGreSQL database will be initialized. When you exit the shell, the PostGreSQL instance will be stopped. If you need to stop PostGres manually, you can run `./postgres-local.sh stop`.


## Installing Phoenix

Follow the Phoenix installation guide linked [here](https://hexdocs.pm/phoenix/up_and_running.html) by running `mix phx.new <project-name>` inside the nix-shell.

When finished, edit the `config/dev.exs` file to include `socket_dir: "#{System.get_env("PGHOST")}",` after the `database` key, replacing the generated line `hostname: "localhost",` with a configuration that looks similar to this:

``` elixir
# Configure your database
config :hello, Hello.Repo,
  username: "postgres",
  password: "postgres",
  database: "hello_dev",
  socket_dir: "#{System.get_env("PGHOST")}",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

With that, you can run `mix ecto.create` from the project directory and you'll be off to the races.


## Regular Usage

After configuring the project to use the `socket_dir` for the local PostGreSQL database, you can run either `mix phx.server` or `iex -S mix phx.server` for regular development on the project.
