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
end
