defmodule RendererTest do
  use ExUnit.Case

  describe "handle_command tests: " do
    test "quit outputs expected results string" do
      expected = "Good bye"

      assert Renderer.handle_command("quit") == expected
    end

    test "start outputs expected results string" do
      expected = """
      Let's go
      These are the following commands:
       1..9 - Choose a position matching one of these numbers
       quit - Quits Tic Tac Toe
      """

      assert {:ok, result} = Renderer.handle_command("start")
      assert result == expected
    end

    test "begin outputs expected results string" do
      expected = """
      Welcome to Tic Tac Toe!
      These are the following commands:
       start - Begin a game of Tic Tac Toe
       quit - Quits Tic Tac Toe
      """

      assert {:ok, result} = Renderer.handle_command("begin")
      assert result == expected
    end

    test "1 outputs expected results string" do
      expected = """
       o | 2 | 3 
       4 | 5 | 6 
       7 | 8 | 9 
      Player x's move:
      """

      Renderer.handle_command("start")
      assert {_, result} = Renderer.handle_command("1")
      assert result == expected
    end

    test "O is winner output" do
      expected = """
       o | o | o 
       x | x | 6 
       7 | 8 | 9 
      Player O wins! Thanks for playing.
      """

      Renderer.handle_command("start")
      Renderer.handle_command("1")
      Renderer.handle_command("4")
      Renderer.handle_command("2")
      Renderer.handle_command("5")

      {_, result} = Renderer.handle_command("3")
      assert result == expected
    end
  end
end
