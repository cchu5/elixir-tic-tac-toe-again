defmodule CLI do
  
  def main do
    IO.puts("Welcome to Tic Tac Toe!")
  end

  def print_help_msg(commands) do
    IO.puts("These are the following commands:")
    Enum.map(commands, fn {command, description} -> IO.puts(" #{command} - #{description}") end)
  end
end
