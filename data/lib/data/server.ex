defmodule Data.Server do
  use GenServer

  alias Data.ElasticSearch

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    IO.puts("Data server booting up")
    {:ok, nil}
  end

  def handle_call({:es_search_posts, query}, _from, state) do
    result = ElasticSearch.search_posts(query)
    {:reply, result, state}
  end

  def handle_cast({:es_insert_posts, data}, state) do
    ElasticSearch.insert_posts(data)
    {:noreply, state}
  end
end
