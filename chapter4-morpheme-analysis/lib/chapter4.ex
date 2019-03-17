defmodule Chapter4 do
  @moduledoc """
  NLP Chapter4 in Elixir.
  """

  @doc """
  Run

  ## Examples

      iex> Chapter4.solve()
      :world

  """
  def solve do
    stream = P30Read.solve
    stream |> P31FetchVerb.solve |> Enum.to_list |> IO.inspect
    stream |> P32FetchVerbBase.solve |> Enum.to_list |> IO.inspect
    stream |> P33FetchNounSahen.solve |> Enum.to_list |> IO.inspect
  end
end
