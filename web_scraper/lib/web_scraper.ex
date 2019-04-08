defmodule WebScraper do
  @moduledoc """
    API for interacting with the forum web scraper
  """

  alias WebScraper.Server

  def scrape(key, pages) do
    GenServer.cast(Server, {:scrape, key, pages})
  end

  def watch(key) do
    Process.send(Server, {:watch, key}, [])
  end

  def inspect(key) do
    GenServer.call(Server, {:inspect, key})
  end

  def clear(key) do
    GenServer.call(Server, {:clear, key})
  end
end
