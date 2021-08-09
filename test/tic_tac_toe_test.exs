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

  describe "play_at tests: " do
    test "returns a board with :continue" do
      board = TicTacToe.new_board()
      expected_board = TestHelper.create_populated_board([{1,:o}]) 

      assert TicTacToe.play_at(board, 1, :o) == {:ok, expected_board, :continue} 
    end 
  end
end
