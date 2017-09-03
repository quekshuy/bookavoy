defmodule Bookavoy.Book do
  use Bookavoy.Web, :model

  schema "books" do
    field :title, :string
    field :isbn, :string
    field :author, :string
    has_many :prices, Bookavoy.Price
    timestamps()
  end
end
