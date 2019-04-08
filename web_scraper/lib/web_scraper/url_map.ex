defmodule WebScraper.UrlMap do
  @url_map %{
    :headfi => {:headfi, "https://www.head-fi.org/forums/headphones-for-sale-trade.6550/"}
  }

  def get(key) do
    @url_map[key]
  end
end
