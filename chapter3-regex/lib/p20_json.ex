defmodule P20Json do
  @moduledoc """
  Documentation for P20Json.
  """

  @doc """
   Solve Json
  ## Examples

      iex> P20Json.solve()
      :world

  """
  def solve do

    WikiParser.search_by_country("jawiki-country.json", "イギリス")
      |> Enum.each ( &( &1 |> Map.fetch!("text") |> IO.puts ))
  end
end
