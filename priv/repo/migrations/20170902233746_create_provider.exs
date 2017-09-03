defmodule Bookavoy.Repo.Migrations.CreateProvider do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :name, :string
      timestamps()
    end
  end
end
