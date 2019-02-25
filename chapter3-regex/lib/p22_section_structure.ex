defmodule P22SectionStructure do
  @moduledoc false

  def solve() do
    to_display_format = fn (regex_result) -> "#{Enum.at(regex_result, 2)},#{String.length(Enum.at(regex_result, 1))}" end
    WikiParser.search_by_country("jawiki-country.json", "イギリス")
      |> Enum.map_reduce([], &( {&1, &2 ++ &1 |> Map.fetch!("text") |> String.split("\n") } ) )
      |> elem(1)
      |> Enum.filter( &( Regex.match?(~r/^([=]+)([^=]+)([=]+)$/, &1) === true ) )
      |> Enum.each( &( Regex.run(~r/^([=]+)([^=]+)([=]+)$/, &1) |> to_display_format.() |> IO.puts ) )
  end
end
