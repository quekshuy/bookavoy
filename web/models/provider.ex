defmodule Bookavoy.Provider do
  use Bookavoy.Web, :model

  schema "providers" do
    field :name, :string
    timestamps()
  end

  def changeset(provider, params \\ %{}) do
    provider
    |> cast(params, ~w(name))
  end
end
