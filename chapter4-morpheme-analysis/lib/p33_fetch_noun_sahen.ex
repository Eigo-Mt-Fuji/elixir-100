defmodule P33FetchNounSahen do
  @moduledoc false

  def solve(stream) do

    stream |> Stream.filter(&( Map.get(&1, :pos) === "名詞" && Map.get(&1, :pos1) === "サ変接続" ))
  end
end
