defmodule P28RemoveMarkupsEffort do
  @moduledoc false

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
                        |> WikiParser.remove_link
                        |> WikiParser.remove_link_display_text
                        |> WikiParser.remove_redirect_markup
                        |> WikiParser.remove_file_link
                        |> WikiParser.remove_external_link
                        )
                    } )
       )
    |> Enum.reduce( &Enum.into/2 )
    |> Enum.each( & ( elem(&1, 1) |> IO.inspect ))

  end
end
