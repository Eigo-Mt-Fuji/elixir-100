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
  def remove_link(text) do
    Regex.replace(~r/\[\[(?<=\[\[)([^\|\[\]]+)(?=\]\])\]\]/s, text, fn (_, article) -> article end)
  end
  def remove_link_display_text(text) do
    Regex.replace(~r/\[\[(?<=\[\[)([^\|\[\]]+)(?=\|)\|([^\|\[\]]+)(?=\]\])\]\]/s, text, fn (_, _, display_text) -> display_text end)
  end
  def remove_redirect_markup(text) do
    Regex.replace(~r/\#REDIRECT\s\[\[(?<=\[\[)([^\|\[\]]+)(?=\]\])\]\]/s, text, fn (_, article) -> article end)
  end
  def remove_external_link(text) do

  # [http://esa.un.org/unpd/wpp/Excel-Data/population.htm United Nations Department of Economic and Social Affairs>Population Division>Data>Population>Total Population]
    #
    Regex.replace(~r/\[(http(?s)\:\/\/[a-zA-Z0-9\.\/\-\_\&\?\%\@=]+)\s([^\|\]]+)(?=\])\]/s, text, fn (_, b, article) -> article end)
  end
  def fetch_country_flag(text) do
    Regex.replace(~r/(Flag\sof\sthe\sUnited\sKingdom\.svg)/s, text, fn (_, flag) -> "https://upload.wikimedia.org/wikipedia/commons/a/ae/"<>flag end)
  end
  def remove_file_link(text) do
    # [[ファイル:Wikipedia-logo-v2-ja.png|thumb|説明文]]
    Regex.replace(~r/\[\[ファイル:([^\|\[\]]+)\|([^\|\[\]]+)\|([^\|\[\]]+)(?=\]\])\]\]/s, text, fn (_, _, _, display_text) -> display_text end)
  end

end
