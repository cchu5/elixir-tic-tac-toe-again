defmodule CLI do
  @commands [
    {:start, "Begin a game of Tic Tac Toe"},
    {:quit, "Quits Tic Tac Toe"}
  ]

  @game_commands [
    {"1..9", "Choose a position matching one of these numbers"}
  ]

  def main do
    IO.puts("Welcome to Tic Tac Toe!")
    print_help_msg(@commands)
    receive_command()
  end

  def print_help_msg(commands) do
    IO.puts("These are the following commands:")
    Enum.map(commands, fn {command, description} -> IO.puts(" #{command} - #{description}") end)
  end

  def receive_command do
    IO.gets("> ")
    |> String.trim()
    |> String.downcase()
    |> execute_command
  end

  def receive_command(board, player) do
    IO.gets("> ")
    |> String.trim()
    |> String.downcase()
    |> execute_command(board, player)
  end

  def execute_command(command) do
    case command do
      "start" ->
        IO.puts("Let's go")
        print_help_msg(@game_commands)
        board = TicTacToe.new_board()
        print_board(board)
        receive_command(board, :o)

      "quit" ->
        IO.puts("Good bye")

      _ ->
        IO.puts("Invalid command")
        print_help_msg(@commands)
        receive_command()
    end
  end

  def execute_command(command, board, player) do
    next_player = if player == :o, do: :x, else: :o

    case command do
      "1" ->
        TicTacToe.play_at(board, 1, player)
        |> print_output(next_player)

      "2" ->
        TicTacToe.play_at(board, 2, player)
        |> print_output(next_player)

      "3" ->
        TicTacToe.play_at(board, 3, player)
        |> print_output(next_player)

      "4" ->
        TicTacToe.play_at(board, 4, player)
        |> print_output(next_player)

      "5" ->
        TicTacToe.play_at(board, 5, player)
        |> print_output(next_player)

      "6" ->
        TicTacToe.play_at(board, 6, player)
        |> print_output(next_player)

      "7" ->
        TicTacToe.play_at(board, 7, player)
        |> print_output(next_player)

      "8" ->
        TicTacToe.play_at(board, 8, player)
        |> print_output(next_player)

      "9" ->
        TicTacToe.play_at(board, 9, player)
        |> print_output(next_player)

      "quit" ->
        IO.puts("Good bye, #{next_player} wins by default")

      _ ->
        IO.puts("Invalid command")
        print_board(board)
        receive_command(board, player)
    end
  end

  def print_output(results, next_player) do
    {:ok, board, progress} = results
    print_board(board)

    case progress do
      :continue ->
        IO.puts("Player #{next_player}'s move:")
        receive_command(board, next_player)

      :draw ->
        IO.puts("It's a draw, thanks for playing.")

      :winner_x ->
        IO.puts("Player X wins! Thanks for playing.")

      :winner_o ->
        IO.puts("Player O wins! Thanks for playing.")
    end
  end

  defp print_board(board) do
    map_positions_to_string = fn {square, value} ->
      if square in [3, 6, 9] do
        if value != :empty do
          " #{value} \n"
        else
          " #{square} \n"
        end
      else
        if value != :empty do
          " #{value} |"
        else
          " #{square} |"
        end
      end
    end

    visual_board =
      board
      |> Enum.map(map_positions_to_string)
      |> Enum.join("")

    IO.puts(visual_board)
  end
end
