defmodule WebScraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :web_scraper,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {WebScraper.Application, []}
    ]
  end

  defp deps do
    [
      {:data, [path: "../data"]},
      {:httpoison, "~> 1.5"},
      {:floki, "~> 0.20"}
    ]
  end
end
