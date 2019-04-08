defmodule Data.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Data.Server, []}
    ]

    opts = [
      strategy: :one_for_one,
      name: Data.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
