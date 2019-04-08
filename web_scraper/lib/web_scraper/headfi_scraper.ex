defmodule WebScraper.HeadFiScraper do
  def scrape(url) do
    data =
      HTTPoison.get!(url)
      |> Map.get(:body)
      |> Floki.find(".discussionListItems .discussionListItem")
      |> Enum.map(&extract/1)

    [:headfi, data]
  end

  defp extract(item) do
    id = item |> Floki.attribute("id") |> Floki.text() |> normalize_string()
    title = item |> Floki.find(".main .title a") |> Floki.text() |> normalize_title_string()
    author = item |> Floki.attribute("data-author") |> Floki.text() |> normalize_string()
    date = item |> Floki.find("dd .DateTime") |> Floki.text() |> parse_date()
    sold = String.contains?(title, "sold")
    kvdata =
      item
      |> Floki.find(".main .pairsInline dl")
      |> Enum.map(&normalize_keyvals/1)
      |> Enum.reduce(%{}, fn([k, v |_], acc) -> Map.put(acc, k, v) end)

    Map.merge(%{
      id: id,
      title: title,
      author: author,
      date: date,
      sold: sold
    }, kvdata)
  end

  defp normalize_keyvals(kvitem) do
    key = kvitem |> Floki.find("dt") |> Floki.text() |> normalize_string()
    raw_value = kvitem |> Floki.find("dd") |> Floki.text() |> normalize_string()
    value =
      cond do
        String.contains?(raw_value, "sale") ->
          "sale"
        String.contains?(raw_value, "wanted") ->
          "wanted"
        true ->
          raw_value
      end
    [key, value]
  end

  defp normalize_string(str) do
    str
    |> String.downcase()
    |> String.replace("\n", "")
    |> String.replace("\t", "")
    |> String.replace(":", "")
    |> String.replace(" ", "")
    |> String.trim()
  end

  defp normalize_title_string(str) do
    str
    |> String.downcase()
    |> String.replace("fs", "")
    |> String.replace("for sale", "")
    |> String.replace(":", "")
    |> String.trim()
  end

  defp parse_date(date) do
    date_array =
      date
      |> String.split("at")
      |> Enum.at(0)
      |> String.trim()
      |> String.replace(",", "")
      |> String.replace("Jan", "1")
      |> String.replace("Feb", "2")
      |> String.replace("Mar", "3")
      |> String.replace("Apr", "4")
      |> String.replace("May", "5")
      |> String.replace("Jun", "6")
      |> String.replace("Jul", "7")
      |> String.replace("Aug", "8")
      |> String.replace("Sep", "9")
      |> String.replace("Oct", "10")
      |> String.replace("Nov", "11")
      |> String.replace("Dec", "12")
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    {:ok, date } = Date.new(date_array |> Enum.at(2), date_array |> Enum.at(0), date_array |> Enum.at(1))
    date
  end
end
