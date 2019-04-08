defmodule DashboardWeb.InsightChannel do
  use Phoenix.Channel

  require Logger

  def join("dashboard:insight", _, socket) do
    # do something on connection
    { :ok, socket }
  end

  def handle_in("recommendations", _, socket) do
    recommendations = Insight.top10_recommendations()
    push(socket, "recommendations", %{recommendations: recommendations})
    { :noreply, socket }
  end
end
