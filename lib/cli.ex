defmodule CLI do
  @commands [
    {:start, "Begin a game of Tic Tac Toe"},
    {:quit, "Quits Tic Tac Toe"}
  ]
  
  def main do
    IO.puts("Welcome to Tic Tac Toe!")
  end

  def print_help_msg(commands) do
    IO.puts("These are the following commands:")
    Enum.map(commands, fn {command, description} -> IO.puts(" #{command} - #{description}") end)
  end

  def receive_command do
    IO.gets("> ")
    |> String.trim
    |> String.downcase
    |> execute_command
  end

  def execute_command(command) do
    case command do
      "start" ->
        IO.puts("Let's go")
      "quit" -> IO.puts("Good bye")
      _ -> 
        IO.puts("Invalid command")
        print_help_msg(@commands)
        receive_command()
    end
  end
end
