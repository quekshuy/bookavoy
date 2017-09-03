defmodule Slack do
  @moduledoc """
  A means to parse slack internal app messages to our endpoint.
  """

  def parse_slash_command(text) do
    [title | tail] = String.split(text, "author:")
    %{ title: title, author: Enum.at(tail, 0) }
  end

end
