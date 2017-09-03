defmodule Bookavoy.Price do
  use Bookavoy.Web, :model

  schema "prices" do
    field :value, :decimal
    # for now assume that currency is going to be usd
    belongs_to :provider, Bookavoy.Provider
    has_many :price_queries, Bookavoy.PriceQuery
    timestamps()
  end
end
