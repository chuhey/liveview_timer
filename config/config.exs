# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_view_counter,
  ecto_repos: [LiveViewCounter.Repo]
  
config :live_view_counter, LiveViewCounter.Repo,
  database: "live_view_counter_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
  
# Configures the endpoint
config :live_view_counter, LiveViewCounterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fbVXRM6m2JPtYpi0aRcXyAurqqv+7VTQAMoWCR8qkb/5WWUy7CGoAs210/Hr+5/q",
  render_errors: [view: LiveViewCounterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LiveViewCounter.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "re+H/6tBmwGaV3XabOCAw0U1DMOScvIp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
