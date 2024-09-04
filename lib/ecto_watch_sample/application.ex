defmodule EctoWatchSample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EctoWatchSampleWeb.Telemetry,
      EctoWatchSample.Repo,
      {DNSCluster, query: Application.get_env(:ecto_watch_sample, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EctoWatchSample.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: EctoWatchSample.Finch},
      # Start a worker by calling: EctoWatchSample.Worker.start_link(arg)
      # {EctoWatchSample.Worker, arg},
      # Start to serve requests, typically the last entry
      EctoWatchSampleWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EctoWatchSample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EctoWatchSampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end