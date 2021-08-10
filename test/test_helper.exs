defmodule TestHelper do
  def create_populated_board(positions_and_players) do
    mapped_tuples = Enum.into(positions_and_players, %{})

    Enum.map(1..9, fn square ->
      if mapped_tuples[square], do: {square, mapped_tuples[square]}, else: {square, :empty}
    end)
    |> Map.new()
  end
end

ExUnit.start()
