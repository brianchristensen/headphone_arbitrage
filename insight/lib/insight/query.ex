defmodule Insight.Query do
  # TODO: Still picking up items with price 0 or 1, need to fix
  def items_for_sale(size) do
    """
    {
      "size": #{size},
      "query": {
        "bool": {
          "must": [
            { "match": { "type": "sale" } },
            { "match": { "sold": "false" } },
            { "match": { "currency": "usd" } }
          ],
          "must_not" : [
            { "match": { "price": "0" } },
            { "match": { "price": "1" } }
          ]
        }
      },
      "sort": [
        { "date": "desc" }
      ]
    }
    """
  end

  # TODO: Change find_similar query so that it has a higher levenshtein threshold - matching too dissimilar currently
  def find_similar(field, value, size) do
    """
    {
      "size": #{size},
      "query": {
        "bool": {
          "must": [
            { "match": { "type": "sale" } },
            { "match": { "currency": "usd" } },
            {
              "match": {
                "#{field}": {
                  "query": "#{value}",
                  "fuzziness": "AUTO"
                }
              }
            }
          ],
          "must_not" : [
            { "match": { "price": "0" } },
            { "match": { "price": "1" } }
          ]
        }
      }
    }
    """
  end
end
