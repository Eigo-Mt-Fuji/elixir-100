defmodule WikiParser do
  @moduledoc false

  def search_by_country(file_name, country_name) do
    file_name
    |> File.stream!
    |> Enum.map( &(Jason.decode!(&1)) )
    |> Enum.filter(&( Regex.run(~r/#{country_name}/, &1 |> Map.fetch!("title") ) ))
  end
end
