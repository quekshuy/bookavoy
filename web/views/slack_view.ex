defmodule Bookavoy.SlackView do
  use Bookavoy.Web, :view

  def render("slash.json", %{ gb_result: gb_result }) do
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
    %{
      text: "This is what we found.",
      response_type: "ephemeral",
      attachments: Enum.map(Enum.slice(gb_result["items"], 0, 20), &item_to_attachment/1)
    }
  end

  defp item_to_attachment(item) do
    vol_info = item["volumeInfo"]
    sales_info = item["saleInfo"]
    %{
      fallback: vol_info["title"],
      author_name: Enum.at(vol_info["authors"], 0),
      title: vol_info["title"],
      fields: [
        %{
          title: "Description",
          value: vol_info["description"],
          short: false
        },
        %{
          title: "Price",
          value: "#{sales_info["listPrice"]["currencyCode"]} #{sales_info["listPrice"]["amount"]}",
          short: true
        }
      ],
      thumb_url: vol_info["imageLinks"]["smallThumbnail"]
    }
  end

end
