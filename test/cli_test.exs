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
end
