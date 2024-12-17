defmodule Calander.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CalanderWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:calander, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Calander.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Calander.Finch},
      # Start a worker by calling: Calander.Worker.start_link(arg)
      # {Calander.Worker, arg},
      # Start to serve requests, typically the last entry
      CalanderWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Calander.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CalanderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
