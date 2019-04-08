defmodule Insight.MixProject do
  use Mix.Project

  def project do
    [
      app: :insight,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Insight.Application, []}
    ]
  end

  defp deps do
    [
      {:data, [path: "../data"]},
      {:statistics, "~> 0.5.0"}
    ]
  end
end
