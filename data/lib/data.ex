defmodule Data do
  @moduledoc """
    API for interacting with the post datasource (elasticsearch)
  """

  alias Data.Server

  def es_search_posts(query) do
    GenServer.call(Server, {:es_search_posts, query})
  end

  def es_insert_posts(data) do
    GenServer.cast(Server, {:es_insert_posts, data})
  end
end
