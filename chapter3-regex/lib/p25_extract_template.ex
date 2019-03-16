defmodule P25ExtractTemplate do
  @moduledoc false

  defp _cleanser(_, key, ope, val) do
    key <> ope <> val |> String.replace("\n", " ")
  end

# key = value<ref>xxx</ref>
  def solve() do

    wiki_text = WikiParser.search_by_country("jawiki-country.json", "イギリス") |> WikiParser.fetch_text(0)

    [ _original | matches ] = Regex.run(~r/\{\{基礎情報\s([^\s]+)\n(.+)(?=\n\}\}\n)/s, wiki_text)
    [ _country, templates ] = matches

    templates
    |> String.trim_leading("|")
    |> String.trim_trailing("\n")
    |> String.split("\n|")
    |> Enum.map( fn (item) -> "|"<>item end )
    |> Enum.map(fn (item) -> Regex.replace(~r/^(\|.+)(?=\s\=\s)(\s=\s)(.+)$/s, item, &( _cleanser(&1, &2, &3, &4) )) end)
    |> Enum.map( &( Regex.run(~r/^\|(.+)(?=\s\=\s)\s=\s(.+)$/s, &1) ) )
    |> Enum.map( &( %{&1 |> Enum.at(1) => &1 |> Enum.at(2) }) )
    |> Enum.reduce( &Enum.into/2 )
    |> IO.inspect
  end
end