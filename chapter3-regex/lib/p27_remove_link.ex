defmodule P27RemoveLink do
  @moduledoc false

  defp _remove_link(text) do
    Regex.replace(~r/\[\[(?<=\[\[)([^\|\[\]]+)(?=\]\])\]\]/s, text, fn (_, article) -> article end)
  end
  defp _remove_link_display_text(text) do
    Regex.replace(~r/\[\[(?<=\[\[)([^\|\[\]]+)(?=\|)\|([^\|\[\]]+)(?=\]\])\]\]/s, text, fn (_, _, display_text) -> display_text end)
  end
  def solve() do

    wiki_text = WikiParser.search_by_country("jawiki-country.json", "イギリス") |> WikiParser.fetch_text(0)
    # 基礎情報の抽出
    [ _original, _country, templates ]
    = Regex.run(~r/\{\{基礎情報\s([^\s]+)\n\|(.+)(?=\n\}\}\n)/s, wiki_text)

    # 肯定先読み /
    templates
    |> String.split("\n|")
      # クレンジング（値に含まれる改行コードの置換）
    |> Enum.map( fn (item) -> Regex.replace(~r/^(.+)(?=\s\=\s)(\s=\s)(.+)$/s, item, &WikiParser.cleanser/4) end )
      # 正規表現　フィルタ
    |> Enum.filter( &( Regex.match?(~r/^(.+)(?=\s\=\s)\s=\s(.+)$/s, &1) ) )
      # 正規表現　抽出
    |> Enum.map( &( Regex.run(~r/^(.+)(?=\s\=\s)\s=\s(.+)$/s, &1) ) )
      # List -> Map, Remove highlight
    |> Enum.map( &( %{
        (&1 |> Enum.at(1)) => (
          &1
          |> Enum.at(2)
          |> WikiParser.remove_highlight(5)
          |> WikiParser.remove_highlight(3)
          |> WikiParser.remove_highlight(2)
          |> _remove_link
          |> _remove_link_display_text
          )
      } )
     )
    |> Enum.reduce( &Enum.into/2 )
    |> Enum.each( & ( elem(&1, 1) |> IO.inspect ))

  end
end
