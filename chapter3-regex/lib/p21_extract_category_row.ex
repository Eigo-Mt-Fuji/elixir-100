defmodule P21ExtractCategoryRow  do
  @moduledoc """
  Documentation for P21ExtractCategoryRow.
  """

  @doc """
   Solve Json
  ## Examples

      iex> P21ExtractCategoryRow.solve()
      :world

  """
  def solve do

    WikiParser.search_by_country("jawiki-country.json", "イギリス")
    |> Enum.map( &( &1 |> Map.fetch!("text") |> String.split("\n")) )
    |> Enum.reduce( [], &( &2 ++ &1 ) )
    |> Enum.filter( &( Regex.match?(~r/\[\[Category:([^\[\]]+)\]\]/, &1) === true ) )
    |> Enum.each( & (&1 |> IO.puts) )
  end
end
