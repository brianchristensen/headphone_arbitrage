defmodule DashboardWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "dashboard:insight", DashboardWeb.InsightChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
