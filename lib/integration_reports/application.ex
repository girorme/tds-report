defmodule IntegrationReports.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      IntegrationReportsWeb.Telemetry,
      # Start the Ecto repository
      IntegrationReports.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: IntegrationReports.PubSub},
      # Start Finch
      {Finch, name: IntegrationReports.Finch},
      # Start the Endpoint (http/https)
      IntegrationReportsWeb.Endpoint
      # Start a worker by calling: IntegrationReports.Worker.start_link(arg)
      # {IntegrationReports.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IntegrationReports.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IntegrationReportsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
