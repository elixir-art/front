defmodule WeHr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WeHrWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:we_hr, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WeHr.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WeHr.Finch},
      # Start a worker by calling: WeHr.Worker.start_link(arg)
      # {WeHr.Worker, arg},
      # Start to serve requests, typically the last entry
      WeHrWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WeHr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WeHrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
