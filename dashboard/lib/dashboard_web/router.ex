defmodule DashboardWeb.Router do
  use DashboardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authentication do
    plug BasicAuth, use_config: {:dashboard, :authentication}
  end

  scope "/", DashboardWeb do
    pipe_through [:browser, :authentication]

    get "/", PageController, :index
  end
end
