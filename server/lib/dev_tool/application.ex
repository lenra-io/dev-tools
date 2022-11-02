defmodule DevTool.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    DevTool.MigrationHelper.migrate()
    DevTool.Seeds.run()

    children =
      [
        DevTool.Repo,
        # Start the Telemetry supervisor
        DevTool.Telemetry,
        # Start the PubSub system
        {Phoenix.PubSub, name: DevTool.PubSub}
      ] ++
        [
          # Start the Finch http client
          Supervisor.child_spec(
            {Finch,
             name: FaasHttp,
             pools: %{
               Application.fetch_env!(:dev_tools, :application_url) => [size: 32, count: 8]
             }},
            id: :finch_faas_http
          ),
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
