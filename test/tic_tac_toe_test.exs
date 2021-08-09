defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  describe "new_board tests: " do
    test "creates a new board" do
      board = TicTacToe.new_board()
  
      assert is_map(board) == true
      assert board |> map_size == 9
      assert board |> Enum.fetch(0) == {:ok, {1, :empty}}
    end
  end
end
