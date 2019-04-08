defmodule Data.ElasticSearch do
  @addr Application.get_env(:data, :elasticsearch_address)
  @posts "#{@addr}/posts"

  # query must be a multiline string literal e.g.
  # q = """
  #   {
  #     "size": 100,
  #     "query": { "match_all": {} },
  #     "sort": [
  #       { "date": "desc" }
  #     ]
  #   }
  # """
  def search_posts(query) do
    res =
      "#{@posts}/_search"
      |> HTTPoison.post!(query |> String.replace("\n", ""), [{"Content-Type", "application/json"}])
      |> Map.get(:body)
      |> Poison.decode!()
    cond do
      is_integer(res["status"]) -> # this means the query was not successful
        res
      true -> # otherwise it was successful so unwrap it
        res |> get_in(["hits", "hits"])
    end
  end

  def insert_post(post) do
    "#{@posts}/_doc/#{post.id}"
    |> HTTPoison.put!(post |> Poison.encode!(), [{"Content-Type", "application/json"}])
  end

  def insert_posts(posts) do
    posts |> Enum.each(&insert_post/1)
  end
end
