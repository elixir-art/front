defmodule MySuperCalendar.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MySuperCalendarWeb.Telemetry,
      MySuperCalendar.Repo,
      {DNSCluster, query: Application.get_env(:my_super_calendar, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MySuperCalendar.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MySuperCalendar.Finch},
      # Start a worker by calling: MySuperCalendar.Worker.start_link(arg)
      # {MySuperCalendar.Worker, arg},
      # Start to serve requests, typically the last entry
      MySuperCalendarWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MySuperCalendar.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MySuperCalendarWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
