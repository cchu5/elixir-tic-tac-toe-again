defmodule TicTacToe do
  @moduledoc """
  Documentation for `TicTacToe`.
  """

  @doc """
  """
  
  def new_board do
    for square <- 1..9, into: %{}, do: {square, :empty} 
  end

  def play_at(board, position, player) do
    with {:ok, valid_player} <- check_player(player),
			 	 {:ok, new_board} <- choose_square(board, position, valid_player),
         {:ok, progress} <- check_progress(new_board, valid_player),
      do: progress
  end
    
# -------------------------------------------------------------
# --------------------Private----------------------------------
# -------------------------------------------------------------

	defp check_player(player) do
		case player do
			:x -> {:ok, player}
			:o -> {:ok, player}
			_ -> {:error, :invalid_player}
		end
	end

  defp choose_square(board, position, player) do
    case board[position] do
      nil -> {:error, :invalid_position}
      :o -> {:error, :taken}
      :x -> {:error, :taken}
      :empty -> {:ok, %{board | position => player}}
    end
  end

  defp check_progress(board, player) do
    cond do
			# Horizontal
			in_a_row(board, [1,2,3], player) -> {:ok, board, String.to_atom("winner_#{player}")} 
			in_a_row(board, [4,5,6], player) -> {:ok, board, String.to_atom("winner_#{player}")} 
			in_a_row(board, [7,8,9], player) -> {:ok, board, String.to_atom("winner_#{player}")} 
			# Vertical
			in_a_row(board, [1,4,7], player) -> {:ok, board, String.to_atom("winner_#{player}")}
			in_a_row(board, [2,5,8], player) -> {:ok, board, String.to_atom("winner_#{player}")}
			in_a_row(board, [3,6,9], player) -> {:ok, board, String.to_atom("winner_#{player}")}
			# Diagonal
			in_a_row(board, [1,5,9], player) -> {:ok, board, String.to_atom("winner_#{player}")}
			in_a_row(board, [3,5,7], player) -> {:ok, board, String.to_atom("winner_#{player}")}
      # In progress game
      board -> {:ok, board, :continue}
    end
  end

	defp in_a_row(board, positions, player) do
		board
		|> Enum.map(fn {position, value} -> if position in positions, do: value end)
		|> Enum.filter(fn value -> value != nil end) == [player, player, player]
	end
end
