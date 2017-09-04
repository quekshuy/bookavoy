defmodule Bookavoy.SlackView do
  use Bookavoy.Web, :view


  def render("slash.json", %{ gb_result: gb_result }) do
    if gb_result["items"] do
      # Render the slash command response
      # Response should be of the following format:
      # {
      #   "text": "",
      #   "attachments": [
      #     {
      #       "fallback"
      #       "pretext"
      #       "author_name"
      #       "author_link"
      #       "title"
      #       "title_link"
      #       "text"
      #       "fields" : [
      #         {
      #           "title"
      #           "value"
      #           "short"
      #         }
      #       ]
      #       "image_url"
      #       "thumb_url"
      #     }
      #   ]
      # }
      # TODO:
      # 1. Filter only for books that can be purchase.
      # 2. Use an affiliate link for making purchases.
      IO.inspect gb_result
      %{
        text: "This is what we found.",
        response_type: "ephemeral",
        attachments: Enum.map(Enum.slice(gb_result["items"], 0, 20), &item_to_attachment/1)
      }
    else
      %{ 
        text: "Found nothing",
        response_type: "ephemeral"
      }
    end
  end

  defp item_to_attachment(item) do
    vol_info = item["volumeInfo"]
    sales_info = item["saleInfo"]
    %{
      fallback: vol_info["title"],
      title: vol_info["title"],
      fields: [
        %{
          title: "Blurb",
          value: vol_info["description"],
          short: false
        },
        %{
          title: "Price",
          value: "#{sales_info["listPrice"]["currencyCode"]} #{sales_info["listPrice"]["amount"]}",
          short: true
        }
      ],
      thumb_url: vol_info["imageLinks"]["smallThumbnail"],
      attachment_type: "default",
      actions: [
        %{
          "name": "follow",
          "text": "Follow",
          "type": "button",
          "value": "follow"
        }
      ]
    } 
    |> author_info(item)
    |> callback_id(item)
  end

  defp author_info(attachment, item) do
    authors = item["volumeInfo"]["authors"]
    cond do
      is_nil(authors) -> attachment
      length(authors) == 0 -> attachment
      true ->
        Map.put_new(attachment, :author_name, Enum.at(item["volumeInfo"]["authors"], 0))
    end
  end

  defp callback_id(attachment, item) do
    isbn_type = "isbn_13"
    finder = fn (type) ->
      Enum.find(item["volumeInfo"]["industryIdentifiers"], nil, fn(x) ->  x["type"] == type end) end

    isbn = finder.("ISBN_13")
    if is_nil(isbn) do
      isbn_type = "isbn_10"
      isbn  = finder.("ISBN_10")["identifier"]
    else
      isbn = isbn["identifier"]
    end
    Map.put_new(attachment, :callback_id, ~s({"provider": "google", "#{isbn_type}": "#{isbn}"}))
  end

end
