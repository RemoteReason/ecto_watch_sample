defmodule EctoWatchSample.Repo do
  use Ecto.Repo,
    otp_app: :ecto_watch_sample,
    adapter: Ecto.Adapters.Postgres
end
