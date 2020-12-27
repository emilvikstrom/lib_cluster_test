defmodule LibClusterTest.Application do
  require Logger
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      example: [
        strategy: ClusterEC2.Strategy.Tags,
        config: [
          ec2_tagname: "elixir-cluster"
        ]
      ]
    ]

    Logger.debug("Starting #{inspect(topologies)}")

    children = [
      # Starts a worker by calling: LibClusterTest.Worker.start_link(arg)
      # {LibClusterTest.Worker, arg}a
      {Cluster.Supervisor, [topologies, [name: LibClusterTest.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LibClusterTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
