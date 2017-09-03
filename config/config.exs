# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bookavoy,
  ecto_repos: [Bookavoy.Repo]

# Configures the endpoint
config :bookavoy, Bookavoy.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ufjpMMa70V2xbNriKg+2AHHL5EgsCAq9cSvNHGL7Wn0OEGvf/v57/4Q9+fqzI6qM",
  render_errors: [view: Bookavoy.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bookavoy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Application constants
config :bookavoy, 
  slack_verification_token: "xnOWK25n1u4O2eGIexv0DaZ4"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
