# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :data, elasticsearch_address: "http://localhost:9200" #System.get_env("ESADDR")
