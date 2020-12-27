import Config

config :libcluster,
  debug: true,
  topologies: [
    example: [
      strategy: ClusterEC2.Strategy.Tags,
      config: [
        ec2_tagname: "elixir-cluster"
      ]
    ]
  ]
