defmodule Bookavoy.PriceQuery do
  use Bookavoy.Web, :model

  schema "price_queries" do
    belongs_to :price, Bookavoy.Price
    timestamps()
  end
end
