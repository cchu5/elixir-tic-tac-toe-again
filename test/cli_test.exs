defmodule CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "main tests: " do
    test "Player O wins" do
      io_output =
        capture_io([input: "start\n1\n4\n2\n5\n3", capture_prompt: false], fn -> CLI.main() end)

      assert String.contains?(io_output, "Player O wins! Thanks for playing.") == true
    end

    test "Player X wins" do
      io_output =
        capture_io([input: "start\n1\n4\n2\n5\n9\n6", capture_prompt: false], fn -> CLI.main() end)

      assert String.contains?(io_output, "Player X wins! Thanks for playing.") == true
    end

    test "Game ends with a draw" do
      io_output =
        capture_io([input: "start\n1\n2\n3\n5\n4\n7\n6\n9\n8", capture_prompt: false], fn ->
          CLI.main()
        end)

      assert String.contains?(io_output, "It's a draw, thanks for playing.")
    end
  end

  describe "receive_command/1 tests: " do
    test "quit command returns Good bye" do
      expected =
        capture_io([input: "quit", capture_prompt: false], fn -> CLI.receive_command() end)
        |> String.contains?("Good bye")

      assert expected == true
    end

    test "random string command returns Invalid command" do
      expected =
        capture_io([input: "random\nquit", capture_prompt: false], fn -> CLI.receive_command() end)
        |> String.contains?("Invalid command")

      assert expected == true
    end
  end

  describe "receive_command/2 tests: " do
    test "1..9 command returns next player's move" do
      board = TicTacToe.new_board()

      expected =
        capture_io([input: "1\nquit", capture_prompt: false], fn ->
          CLI.receive_command(board, :o)
        end)
        |> String.contains?("Player x's move:")

      assert expected == true
    end
  end
end
