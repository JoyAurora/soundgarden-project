defmodule Soundgarden.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :filename, :string
      add :place_id, references(:places, on_delete: :nothing)

      timestamps()
    end

    create index(:images, [:place_id])
  end
end
