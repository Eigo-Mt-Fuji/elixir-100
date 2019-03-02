defmodule P24ExtractReference do
  @moduledoc false

  def solve() do

    WikiParser.search_by_country("jawiki-country.json", "イギリス")
    |> WikiParser.fetch_text_lines
    |> Enum.each ( &( &1 |> IO.puts ))
  end
end
