# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :chatty, Chatty.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MVnpbOCffzJ5trBQH8DC9XU+tXhZpc3Vo6+eZSIi/iyul2rPiw35yI+46sm4z4iP",
  render_errors: [view: Chatty.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chatty.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
