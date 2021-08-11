defmodule Renderer do
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
				|> Enum.join("")
			"start" ->
				["Let's go\n"]
				|> generate_help_msg(@game_commands)
				|> Enum.join("")
			"quit" ->
				"Good bye"
		end
	end

	defp generate_help_msg(string_list, commands) do
		commands_list =	commands
		|> Enum.map(fn {command, description} -> " #{command} - #{description}\n" end)
		
		commands_list = ["These are the following commands:\n" | commands_list]
		string_list ++ commands_list
		# |> Enum.join("") 
	end
end
