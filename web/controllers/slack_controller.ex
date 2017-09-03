defmodule Bookavoy.SlackController do
  use Bookavoy.Web, :controller

  @doc """
  Responds to a command. Gives users. Formulates
  a response. Sends something with buttons back for 
  the user to respond to. Only the top 20
  """
  def slash(conn, params \\ %{}) do
    # params will have text, and response_url
    # Full params here: https://api.slack.com/slash-commands

    # 1. parse the slash command
    # 2. use the google search API
    # 3. Send it out.
    %{ title: title, author: author } = Slack.parse_slash_command(params["text"])
    case GoogleBooks.search(title, author) do
      {:ok, gb_result} ->
        render conn, "slash.json", gb_result: gb_result
      {:error, _} ->
        conn
        |> put_status(400)
        |> text("jia lat loh")
    end
  end

end

