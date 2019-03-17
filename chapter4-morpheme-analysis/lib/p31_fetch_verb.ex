defmodule P31FetchVerb do
  @moduledoc false

  def solve(stream) do
    stream |> Stream.filter( &(Map.get(&1, :pos) === "動詞") )  |> Stream.map( &(Map.get(&1, :surface)) )
  end
end
