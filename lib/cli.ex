defmodule CLI do
  def main do
		{:ok, output} = Renderer.handle_command("begin")
		IO.puts(output)
		receive_command()
  end


  defp receive_command do
    result = 
		IO.gets("> ")
    |> String.trim()
    |> String.downcase()
		|> Renderer.handle_command

		{progress, output} = result

		IO.puts(output)

		if progress == :ok do
			receive_command()
		end
  end
end
