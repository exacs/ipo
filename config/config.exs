# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ipo,
  ecto_repos: [Ipo.Repo]

# Configures the endpoint
config :ipo, Ipo.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Eps6C/9VzC24xV9kmZ22MwNutqkqcpVafHO6AZfNyVKV97bmQ9DnKDGdJ6xbjK7C",
  render_errors: [view: Ipo.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ipo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
