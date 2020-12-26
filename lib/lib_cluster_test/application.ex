defmodule LibClusterTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      gossip_example: [
        strategy: Elixir.Cluster.Strategy.Gossip,
        config: [
          port: 45892,
          if_addr: "0.0.0.0",
          multicast_if: "192.168.1.1",
          multicast_addr: "230.1.1.251",
          multicast_ttl: 1,
          secret: "somepassword"
        ]
      ]
    ]

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
