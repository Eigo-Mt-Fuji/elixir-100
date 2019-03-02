defmodule P24ExtractReference do
  @moduledoc false

  def solve() do

    WikiParser.search_by_country("jawiki-country.json", "イギリス")
    |> WikiParser.fetch_text_lines
    |> Enum.filter( &( Regex.match?(~r/ファイル:(.+)/, &1) ) )
    |> Enum.each( &( Regex.run(~r/ファイル:(.+)\|(.+)/, &1) |> Enum.at(1) |> IO.puts) )
  end
end
