import Config

config :bors, BorsNG.Database.RepoPostgres,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  timeout: {:system, :integer, "DATABASE_TIMEOUT", 15_000},
  pool_size: {:system, :integer, "POOL_SIZE", 10},
  loggers: [{Ecto.LogEntry, :log, []}],
  ssl: {:system, :boolean, "DATABASE_USE_SSL", true},
  prepare: {:system, :atom, "DATABASE_PREPARE_MODE", :named},
  priv: "priv/repo"

config :bors, BorsNG.Database.RepoMysql,
  adapter: Ecto.Adapters.MyXQL,
  url: {:system, "DATABASE_URL"},
  ssl: {:system, :boolean, "DATABASE_USE_SSL", true},
  timeout: {:system, :integer, "DATABASE_TIMEOUT", 15_000},
  pool_size: {:system, :integer, "POOL_SIZE", 10},
  loggers: [{Ecto.LogEntry, :log, []}],
  ssl: {:system, :boolean, "DATABASE_USE_SSL", true},
  priv: "priv/repo"

config :bors, BorsNG.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [
    host: {:system, "PUBLIC_HOST"},
    scheme: {:system, "PUBLIC_PROTOCOL", "https"},
    port: {:system, :integer, "PUBLIC_PORT", 443}
  ],
  check_origin: false,
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  root: ".",
  version: Application.spec(:myapp, :vsn),
  secret_key_base: {:system, "SECRET_KEY_BASE"},
  ssl: {:system, :boolean, "FORCE_SSL", true},
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

config :bors, BorsNG.WebhookParserPlug, webhook_secret: {:system, "GITHUB_WEBHOOK_SECRET"}

config :bors, BorsNG.GitHub.OAuth2,
  client_id: {:system, "GITHUB_CLIENT_ID"},
  client_secret: {:system, "GITHUB_CLIENT_SECRET"}

config :bors, BorsNG.GitHub.Server,
  iss: {:system, :integer, "GITHUB_INTEGRATION_ID"},
  pem: {:system, {Base, :decode64, []}, "GITHUB_INTEGRATION_PEM"}
