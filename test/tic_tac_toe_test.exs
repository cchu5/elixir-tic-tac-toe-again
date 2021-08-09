defmodule TicTacToeTest do
  use ExUnit.Case
	import TestHelper
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
      expected_board_o = create_populated_board([{1,:o}]) 
      expected_board_x = create_populated_board([{1,:x}]) 

      assert TicTacToe.play_at(board, 1, :o) == {:ok, expected_board_o, :x, :continue} 
			assert TicTacToe.play_at(board, 1, :x) == {:ok, expected_board_x, :o, :continue}
    end 

		test "returns a player has won with a horizontal row" do
      mapped_board_for_horizontal_o_win = 
        create_populated_board([{1,:o}, {2,:o}, {4,:x}, {5,:x}]) 
      mapped_board_for_horizontal_x_win = 
        create_populated_board([{1,:o}, {2,:o}, {4,:x}, {5,:x}]) 

			assert {:ok, _, :winner_o} = TicTacToe.play_at(mapped_board_for_horizontal_o_win, 3, :o)
			assert {:ok, _, :winner_x} = TicTacToe.play_at(mapped_board_for_horizontal_x_win, 6, :x) 
		end

		test "returns a player has won with a vertical row" do
      mapped_board_for_vertical_o_win = 
        create_populated_board([{1,:o}, {2,:x}, {4,:o}, {3,:x}]) 
      mapped_board_for_vertical_x_win = 
        create_populated_board([{1,:o}, {2,:x}, {4,:o}, {5,:x}]) 

			assert {:ok, _, :winner_o} = TicTacToe.play_at(mapped_board_for_vertical_o_win, 7, :o)
			assert {:ok, _, :winner_x} = TicTacToe.play_at(mapped_board_for_vertical_x_win, 8, :x) 
		end

		test "returns a player has won with a diagonal row" do
      mapped_board_for_diagonal_o_win = 
        create_populated_board([{1,:o}, {2,:x}, {5,:o}, {3,:x}]) 
      mapped_board_for_diagonal_x_win = 
        create_populated_board([{1,:o}, {3,:x}, {2,:o}, {5,:x}]) 

			assert {:ok, _, :winner_o} = TicTacToe.play_at(mapped_board_for_diagonal_o_win, 9, :o)
			assert {:ok, _, :winner_x} = TicTacToe.play_at(mapped_board_for_diagonal_x_win, 7, :x) 
		end

		test "returns a game has ended with a draw" do
			mapped_board_for_draw = 
				create_populated_board([{1,:o}, {2,:x}, {3,:o}, {4,:o}, {5,:x}, {6,:o}, {7,:x}])

			assert {:ok, _, :draw} = TicTacToe.play_at(mapped_board_for_draw, 9, :x) 
		end

		test "returns an error with invalid player" do
			board = TicTacToe.new_board()
			
			assert TicTacToe.play_at(board, 1, :z) == {:error, :invalid_player}
		end
	
    test "returns an error with position taken" do
      board = TestHelper.create_populated_board([{1,:o}]) 

      assert TicTacToe.play_at(board, 1, :x) == {:error, :taken} 
    end 

		test "returns an error with invalid position played" do
			board = TicTacToe.new_board()
			
			assert TicTacToe.play_at(board, 10, :o) == {:error, :invalid_position}
		end
  end
end
