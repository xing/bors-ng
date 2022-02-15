import Config

# Configures Elixir's Logger
# Do not include metadata nor timestamps in development logs
case config_env() do
  :prod ->
    config :logger, level: :info

    config :logger, :console,
      format: "$time $metadata[$level] $message\n",
      metadata: [:request_id, :pid]

  :test ->
    config :logger, level: :warn
    config :logger, :console, format: "$message\n"

  _ ->
    config :logger, :console,
      format: "[$level] $message\n",
      metadata: [:request_id, :pid]
end

config :bors,
  ecto_repos: [BorsNG.Database.RepoPostgres],
  api_github_root: {:system, :string, "GITHUB_URL_ROOT_API", "https://api.github.com"},
  html_github_root: {:system, :string, "GITHUB_URL_ROOT_HTML", "https://github.com"},
  api_github_timeout: {:system, :integer, "GITHUB_API_TIMEOUT", 100_000},
  log_outgoing: {:system, "BORS_LOG_OUTGOING", false},
  poll_period: {:system, :integer, "BORS_POLL_PERIOD", 1_800_000}

# General application configuration
config :bors, BorsNG,
  command_trigger: {:system, :string, "COMMAND_TRIGGER", "bors"},
  home_url: "https://bors.tech/",
  allow_private_repos: {:system, :boolean, "ALLOW_PRIVATE_REPOS", false},
  dashboard_header_html:
    {:system, :string, "DASHBOARD_HEADER_HTML",
     """
           <a class=header-link href="https://bors.tech">Home</a>
           <a class=header-link href="https://forum.bors.tech">Forum</a>
           <a class=header-link href="https://bors.tech/documentation/getting-started/">Docs</a>
           <b class=header-link>Dashboard</b>
     """},
  dashboard_footer_html:
    {:system, :string, "DASHBOARD_FOOTER_HTML",
     """
         This service is provided for free on a best-effort basis.
     """}

# Configures the endpoint
config :bors, BorsNG.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RflEtl3q2wkPracTsiqJXfJwu+PtZ6P65kd5rcA7da8KR5Abc/YjB8aZHE4DBxMG",
  render_errors: [view: BorsNG.ErrorView, accepts: ~w(html json)],
  pubsub_server: BorsNG.PubSub

# Overridden by the test config to avoid date-specific behavior
config :bors, :celebrate_new_year, true

# Tesla logger is only enabled if we really need debug info
config :tesla, Tesla.Middleware.Logger, debug: true

config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
