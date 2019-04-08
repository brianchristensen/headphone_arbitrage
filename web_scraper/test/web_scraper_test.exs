defmodule WebScraperTest do
  use ExUnit.Case
  doctest WebScraper

  test "greets the world" do
    assert WebScraper.hello() == :world
  end
end
