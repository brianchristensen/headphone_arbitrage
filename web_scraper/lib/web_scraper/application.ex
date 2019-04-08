defmodule WebScraper.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: WebScraper.TaskSupervisor, restart: :temporary},
      {WebScraper.Server, []}
    ]

    opts = [
      name: WebScraper.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, opts)
  end
end
