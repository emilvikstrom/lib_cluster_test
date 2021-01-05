import Config

config :libcluster,
  debug: true,
  topologies: [
    example: [
      strategy: ClusterEC2.Strategy.Tags,
      config: [
        ec2_tagname: "elixir-cluster-mk2",
        app_prefix: "app",
        show_debug: true
      ]
    ]
  ]

config :ex_aws,
  jason_codec: Jason
