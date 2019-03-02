defmodule WikiParser do
  @moduledoc false

  def search_by_country(file_name, country_name) do
    file_name
    |> File.stream!
    |> Enum.map( &(Jason.decode!(&1)) )
    |> Enum.filter(&( Regex.run(~r/#{country_name}/, &1 |> Map.fetch!("title") ) ))
  end

    def fetch_text_lines( wikis ) do
      wikis
        |> Enum.map_reduce( [], &( {&1, &2 ++ &1 |> Map.fetch!("text") |> String.split("\n") } ) )
        |> elem(1)
  end
end
