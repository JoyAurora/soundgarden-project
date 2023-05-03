defmodule Soundgarden.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :name, :string

      timestamps()
    end
  end
end
