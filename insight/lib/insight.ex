defmodule Insight do
  @moduledoc """
    API which returns insights into forum data
  """

  alias Insight.Server

  def top10_recommendations() do
    GenServer.call(Server, {:top10_recommendations})
  end
end
