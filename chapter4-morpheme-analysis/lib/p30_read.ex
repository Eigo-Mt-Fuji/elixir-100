defmodule P30Read do
  @moduledoc false
  def solve() do
    # 各形態素はマッピング型に格納し
    # 表層形（surface），基本形（base），品詞（pos），品詞細分類1（pos1）をキーとする
    stream
      = "neko.txt.mecab" |> File.stream!
        |> Stream.filter( &( &1 !== "EOS\n" ) )
        |> Stream.map( &( &1 |> String.replace("\t",",") |> String.trim_trailing("\n") |> String.split(",") ) )
    stream
    |> Enum.map( & (%{:surface => Enum.at(&1, 0), :pos => Enum.at(&1, 1), :pos1 =>  Enum.at(&1, 2), :base =>  Enum.at(&1, 7) }) )
  end
end
