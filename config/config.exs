# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tool247,
  ecto_repos: [Tool247.Repo]

# Configures the endpoint
config :tool247, Tool247Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+8YwOfFXu2QCmOsVFQTnNjAcluOv/vwC0yIH0XYoZztMTxHrEzEaiZ/KEf0+9TEl",
  render_errors: [view: Tool247Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tool247.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
