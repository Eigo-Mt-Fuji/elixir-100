defmodule P26RemoveHighlight do
  @moduledoc false

  def remove_highlight(message, lvl) do
    Regex.replace(
      ~r/([\']{#{lvl}})(?<=[\']{#{lvl}})(.+)(?=[\']{#{lvl}})([\']{#{lvl}})/s,
      message,
      fn (_, _, item, _) -> item end
    )
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
    |> Enum.map( &( %{ (&1 |> Enum.at(1)) => (&1 |> Enum.at(2) |> remove_highlight(5) |> remove_highlight(3) |> remove_highlight(2)) } ) )
      # 関数の表記 the format of &Mod.fun/arity
    |> Enum.reduce( &Enum.into/2 )
    |> Enum.each( & ( elem(&1, 1) |> IO.inspect ))
  end
end