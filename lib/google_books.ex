defmodule GoogleBooks do
  @moduledoc """

    Uses Google Books API to search for books and their prices.

  """
  @api_url "https://www.googleapis.com/books/v1/volumes"

  def search(nil, nil) do
    { :error, "Must accept variable" }
  end

  # No author specified
  def search(title, nil) do
    url = @api_url <> "?q=" <> URI.encode(title)
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{ status_code: 200, body: body }} ->
        {:ok, Poison.Parser.parse!(body)}
      {:error, %HTTPoison.Error{ reason: reason }} ->
        {:error, %{ reason: reason }}
    end
  end

  # With an author specified
  def search(title, author) do
    url = @api_url <> "?q=" <> URI.encode(title) <> "+inauthor:" <> URI.encode(author)
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{ status_code: 200, body: body }} ->
        IO.puts body
      {:error, %HTTPoison.Error{ reason: reason }} ->
        IO.inspect reason
    end
  end

end
