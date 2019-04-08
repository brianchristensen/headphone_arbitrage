defmodule Insight.Recommendation do
  alias Insight.Query

  def top_10() do
    similar_price_history(100, 20, 10) # possibly move these values into the config file
  end

  # TODO: Filter price outliers
  defp similar_price_history(sample_size, history_size, take) do
    Data.es_search_posts(Query.items_for_sale(sample_size))
    |> Enum.map(fn r -> Map.get(r, "_source") end)
    |> Enum.reduce([], fn(record, acc) ->
      similar =
        Query.find_similar("title", record["title"], history_size)
        |> Data.es_search_posts()
        |> Enum.map(fn r -> Map.get(r, "_source") end)

      price_list = similar |> Enum.map(fn r -> r["price"] |> parse_price() end)

      summary = get_price_summary(record, price_list)

      [Map.put(summary, :similar, similar) | acc]
    end)
    |> Enum.sort(fn(a, b) -> a.deviation < b.deviation end)
    |> Enum.take(take)
  end

  defp get_price_summary(item, price_list) do
    item_price = item["price"] |> parse_price()
    mean = Statistics.mean(price_list)
    median = Statistics.median(price_list)
    mode = Statistics.mode(price_list)
    deviation = item_price - mean
    %{
      deviation: deviation,
      item_title: item["title"],
      item_price: item_price,
      max_spend: mean - (mean * 0.1),
      mean_price: mean,
      median_price: median,
      mode_price: mode,
      self: item
    }
  end

  defp parse_price(price_str) do
    cond do
      String.contains?(price_str, ".") ->
        price_str |> String.to_float()
      true ->
        price_str |> String.to_integer()
    end
  end
end
