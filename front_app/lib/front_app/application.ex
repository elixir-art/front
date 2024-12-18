defmodule FrontApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FrontAppWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:front_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FrontApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FrontApp.Finch},
      # Start a worker by calling: FrontApp.Worker.start_link(arg)
      # {FrontApp.Worker, arg},
      # Start to serve requests, typically the last entry
      FrontAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FrontApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FrontAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
