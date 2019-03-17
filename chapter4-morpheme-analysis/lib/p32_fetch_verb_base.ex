defmodule P32FetchVerbBase do
  @moduledoc false

  def solve(stream) do
    stream |> Stream.filter( &(&1 |> Map.get(:pos) === "動詞") ) |> Stream.map( &(&1 |> Map.get(:base)) )
  end
end
