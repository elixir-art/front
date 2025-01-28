defmodule MyForm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MyFormWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:my_form, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MyForm.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MyForm.Finch},
      # Start a worker by calling: MyForm.Worker.start_link(arg)
      # {MyForm.Worker, arg},
      # Start to serve requests, typically the last entry
      MyFormWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyForm.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MyFormWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
