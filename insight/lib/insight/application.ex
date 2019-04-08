defmodule Insight.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Insight.Server, []}
    ]

    opts = [
      strategy: :one_for_one,
      name: Insight.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
