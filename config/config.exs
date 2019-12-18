# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config


config :phoenix, template_engines: [
  leex: Phoenix.LiveView.Engine
]

config :team_heda,
  ecto_repos: [TeamHeda.Repo]

# Configures the endpoint
config :team_heda, TeamHedaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yOuN/IxciNjzHedneyTiOmV3UyefCScK135BqAWWNR9X/bGfEgOzbwp4QKsT2tpc",
  render_errors: [view: TeamHedaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TeamHeda.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :team_heda, TeamHeda.Auth.Guardian,
  issuer: "team_heda",
  secret_key: "HNinpKh9Ne3tr8BpjCpAEh0xzCqTIG3PWsfkR2AtzvUaRIpbs6oIQ9RcmjmGPekJ"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
