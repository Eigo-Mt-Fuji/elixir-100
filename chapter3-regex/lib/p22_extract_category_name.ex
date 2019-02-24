defmodule P22ExtractCategoryName do
  @moduledoc false

  def solve() do
    print_writer = fn (regex_result) -> if regex_result !== nil do regex_result |> Enum.at(1) |> IO.puts end end

    WikiParser.search_by_country("jawiki-country.json", "イギリス")
    |> Enum.map_reduce( [], &( {&1, &2 ++ &1 |> Map.fetch!("text") |> String.split("\n") } ) )
    |> elem(1)
    |> Enum.each( &( Regex.run(~r/\[\[Category:(.+)\]\]/, &1) |> print_writer.() ) )
  end
end
