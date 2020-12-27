import Config

config :libcluster,
  debug: true,
  topologies: [
    example: [
      strategy: ClusterEC2.Strategy.Tags,
      config: [
        ec2_tagname: "Type",
        ec2_tagvalue: "elixir-cluster",
        app_prefix: "client",
        show_debug: true
      ]
    ]
  ]
