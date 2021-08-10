defmodule CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "print_help_msg tests: " do
    test "prints initial commands" do
      expected = """
      These are the following commands:
       Test - command
      """

      assert capture_io(fn -> CLI.print_help_msg([{"Test", "command"}]) end) == expected
    end
  end

  describe "receive_command tests: " do
    test "quit command returns Good bye" do
      expected =
        capture_io([input: "quit", capture_prompt: false], fn -> CLI.receive_command() end)
        |> String.contains?("Good bye")

      assert expected == true
    end

    test "start command returns Let's go" do
      expected =
        capture_io([input: "start", capture_prompt: false], fn -> CLI.receive_command() end)
        |> String.contains?("Let's go")

      assert expected == true
    end

    test "random string command returns Invalid command" do
      expected =
        capture_io([input: "random\nquit", capture_prompt: false], fn -> CLI.receive_command() end)
        |> String.contains?("Invalid command")

      assert expected == true
    end
  end
end
