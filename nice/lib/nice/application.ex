defmodule Nice.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NiceWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:nice, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Nice.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Nice.Finch},
      # Start a worker by calling: Nice.Worker.start_link(arg)
      # {Nice.Worker, arg},
      # Start to serve requests, typically the last entry
      NiceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nice.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
