defmodule WebScraper.Server do
  use GenServer

  alias WebScraper.UrlMap
  alias WebScraper.TaskSupervisor
  alias WebScraper.HeadFiScraper

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    IO.puts("WebScraper server booting up")
    # start scraping headfi on bootup and then watch for changes
    GenServer.cast(self(), {:scrape, :headfi, Application.get_env(:web_scraper, :headfi_pages_init)})
    Process.send(self(), {:watch, :headfi, Application.get_env(:web_scraper, :watch_interval_seconds)}, [])

    # initial state is empty map
    {:ok, %{}}
  end

  # inspect current state of keyed scraper
  def handle_call({:inspect, key}, _from, state) do
    {:reply, state[key], state}
  end

  # clear server state
  def handle_call({:clear, key}, _from, state) do
    state = Map.put(state, key, [])
    {:reply, :ok, state}
  end

  # handle headfi scrape requests
  def handle_cast({:scrape, key, num_pages}, state) do
    spawn_scraper(UrlMap.get(key), num_pages)
    { :noreply, state }
  end

  # handle watch request
  def handle_info({:watch, key, interval_seconds}, state) do
    IO.puts("Scraping updates on #{inspect UrlMap.get(key)} - #{inspect :os.system_time(:seconds)}")
    spawn_scraper(UrlMap.get(key), 1)
    # run scraper again every minute
    Process.send_after(self(), {:watch, key, interval_seconds}, interval_seconds * 1000)
    {:noreply, state}
  end

  # scrape task finished successfully, merge result
  def handle_info({_ref, [scraper_key, result |_]}, state) do
    # create or update current scraper state
    scraper_state = state[scraper_key] || []
    # every scraped record must have an id for deduping
    new_scraper_state = Enum.uniq_by(result ++ scraper_state, fn record -> record.id end)
    # persist scraper state
    Data.es_insert_posts(new_scraper_state)

    state = Map.put(state, scraper_key, new_scraper_state)
    {:noreply, state}
  end

  # handle task down normal
  def handle_info({:DOWN, _ref, :process, _pid, :normal}, state) do
    {:noreply, state}
  end

  ### spawn scraper tasks by type ###

  # headfi scraper
  defp spawn_scraper({:headfi, url}, num_pages) do
    for p <- 1..num_pages do
      paged_url =
        cond do
          p == 1 ->
            url
          true ->
            "#{url}page-#{p}"
        end
      Task.Supervisor.async(TaskSupervisor, HeadFiScraper, :scrape, [paged_url])
    end
  end
end
