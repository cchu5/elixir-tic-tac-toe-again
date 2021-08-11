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

			assert Renderer.handle_command("start") == expected
		end
		
		test "begin outputs expected results string" do
			expected = """
			Welcome to Tic Tac Toe!
			These are the following commands:
			 start - Begin a game of Tic Tac Toe
			 quit - Quits Tic Tac Toe
			"""
	
			assert Renderer.handle_command("begin") == expected
		end
	end
end
