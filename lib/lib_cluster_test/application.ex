defmodule LibClusterTest.Application do
  require Logger
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Logger.debug("Starting #{inspect(topologies)}")

    children = [
      # Starts a worker by calling: LibClusterTest.Worker.start_link(arg)
      # {LibClusterTest.Worker, arg}a
      {Cluster.Supervisor, [topologies(), [name: LibClusterTest.ClusterSupervisor]]},
      {Horde.Registry, [name: LibClusterTest.Registry, keys: :unique]}
      # {Horde.DynamicSupervisor, [name: LibClusterTest.ClusterSupervisor, strategy: :one_for_one]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LibClusterTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def topologies(), do: Application.get_env(:libcluster, :topologies)
end
