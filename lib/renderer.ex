defmodule Renderer do
  use Agent

  @commands [
    {:start, "Begin a game of Tic Tac Toe"},
    {:quit, "Quits Tic Tac Toe"}
  ]

  @game_commands [
    {"1..9", "Choose a position matching one of these numbers"},
    {:quit, "Quits Tic Tac Toe"}
  ]

  def handle_command(command) do
    case command do
      "begin" ->
        ["Welcome to Tic Tac Toe!\n"]
        |> generate_help_msg(@commands)
        |> format_output

      "start" ->
        start_link(TicTacToe.new_board(), :board)
        start_link(:o, :player)

        ["Let's go\n"]
        |> generate_help_msg(@game_commands)
        |> format_output

      "quit" ->
        "Good bye"

      "1" ->
        {:ok, new_board, progress, next_player} = play_move(1)

        print_board(new_board)
        |> game_progress(progress, next_player)
        |> format_output

      "2" ->
        {:ok, new_board, progress, next_player} = play_move(2)

        print_board(new_board)
        |> game_progress(progress, next_player)
        |> format_output

      "3" ->
        {:ok, new_board, progress, next_player} = play_move(3)

        print_board(new_board)
        |> game_progress(progress, next_player)
        |> format_output

      "4" ->
        {:ok, new_board, progress, next_player} = play_move(4)

        print_board(new_board)
        |> game_progress(progress, next_player)
        |> format_output

      "5" ->
        {:ok, new_board, progress, next_player} = play_move(5)

        print_board(new_board)
        |> game_progress(progress, next_player)
        |> format_output

      "6" ->
        {:ok, new_board, progress, next_player} = play_move(6)

        print_board(new_board)
        |> game_progress(progress, next_player)
        |> format_output

      "7" ->
        {:ok, new_board, progress, next_player} = play_move(7)

        print_board(new_board)
        |> game_progress(progress, next_player)
        |> format_output

      "8" ->
        {:ok, new_board, progress, next_player} = play_move(8)

        print_board(new_board)
        |> game_progress(progress, next_player)
        |> format_output

      "9" ->
        {:ok, new_board, progress, next_player} = play_move(9)

        print_board(new_board)
        |> game_progress(progress, next_player)
        |> format_output

      _ ->
        ["Invalid command\n"]
        |> format_output
    end
  end

  # -------------------------------------------------------------
  # --------------------Private----------------------------------
  # -------------------------------------------------------------

  defp generate_help_msg(string_list, commands) do
    commands_list =
      commands
      |> Enum.map(fn {command, description} -> " #{command} - #{description}\n" end)

    commands_list = ["These are the following commands:\n" | commands_list]
    string_list ++ commands_list
  end

  defp format_output(string_list) do
    output = Enum.join(string_list, "")
    {:ok, output}
  end

  defp play_move(position) do
    {:ok, board, player} = get_current_state()
    {:ok, new_board, progress} = TicTacToe.play_at(board, position, player)
    {:ok, _, next_player} = update_current_state(new_board, player)
    {:ok, new_board, progress, next_player}
  end

  defp game_progress(string_list, progress, next_player) do
    case progress do
      :continue ->
        output_list = ["Player #{next_player}'s move:\n"]
        string_list ++ output_list

      :draw ->
        output_list = ["It's a draw, thanks for playing.\n"]
        string_list ++ output_list

      :winner_x ->
        output_list = ["Player X wins! Thanks for playing.\n"]
        string_list ++ output_list

      :winner_o ->
        output_list = ["Player O wins! Thanks for playing.\n"]
        string_list ++ output_list
    end
  end

  defp get_current_state do
    board = get_value(:board)
    player = get_value(:player)
    {:ok, board, player}
  end

  defp update_current_state(board, player) do
    next_player = if player == :o, do: :x, else: :o
    update_value(:board, board)
    update_value(:player, next_player)
    {:ok, board, next_player}
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

    board
    |> Enum.map(map_positions_to_string)
  end

  # Agent Functions
  defp start_link(initial_value, name) do
    Agent.start_link(fn -> initial_value end, name: name)
  end

  defp get_value(name) do
    Agent.get(name, & &1)
  end

  defp update_value(name, value) do
    Agent.update(name, fn _ -> value end)
  end
end
