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

  def fetch_text(wikis, index = 0) do
    wikis |> Enum.map( &( &1 |> Map.fetch!("text") ) ) |> Enum.at(index)
  end

  def cleanser(_, key, ope, val) do
    key <> ope <> val |> String.replace("\n", " ")
  end

  def remove_highlight(message, lvl) do
    Regex.replace(
      ~r/([\']{#{lvl}})(?<=[\']{#{lvl}})(.+)(?=[\']{#{lvl}})([\']{#{lvl}})/s,
      message,
      fn (_, _, item, _) -> item end
    )
  end

end
