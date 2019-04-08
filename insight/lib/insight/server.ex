defmodule Insight.Server do
  use GenServer

  alias Insight.Recommendation

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    IO.puts("Insight server booting up")
    {:ok, nil}
  end

  def handle_call({:top10_recommendations}, _from, state) do
    res = Recommendation.top_10()
    {:reply, res, state}
  end
end
