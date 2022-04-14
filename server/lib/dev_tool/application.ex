defmodule DevTool.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DevTool.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DevTool.PubSub},
      # Start the watchdog handler server
      {
        DevTool.Watchdog,
        of_watchdog: Application.fetch_env!(:dev_tools, :of_watchdog),
        upstream_url: Application.fetch_env!(:dev_tools, :upstream_url),
        fprocess: Application.fetch_env!(:dev_tools, :fprocess),
        port: Application.fetch_env!(:dev_tools, :port),
        mode: Application.fetch_env!(:dev_tools, :mode)
      },
      # Start the Finch http client
      {Finch, name: AppHttp},
      # Start the Endpoint (http/https)
      DevTool.Endpoint,
      DevTool.Terminal
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DevTool.Supervisor]

    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DevTool.Endpoint.config_change(changed, removed)
    :ok
  end
end
