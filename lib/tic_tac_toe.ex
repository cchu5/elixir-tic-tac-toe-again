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
    with {:ok, new_board} <- choose_square(board, position, player),
         {:ok, progress} <- check_progress(new_board),
      do: progress
  end
    
# -------------------------------------------------------------
# --------------------Private----------------------------------
# -------------------------------------------------------------

  defp choose_square(board, position, player) do
    case board[position] do
      nil -> {:error, :invalid_position}
      :o -> {:error, :taken}
      :x -> {:error, :taken}
      :empty -> {:ok, %{board | position => player}}
    end
  end

  defp check_progress(board) do
    cond do
      # In progress game
      board -> {:ok, board, :continue}
    end
  end
end
