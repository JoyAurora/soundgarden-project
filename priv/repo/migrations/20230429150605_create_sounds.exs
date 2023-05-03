defmodule Soundgarden.Repo.Migrations.CreateSounds do
  use Ecto.Migration

  def change do
    create table(:sounds) do
      add :filename, :string
      add :object_name, :string
      add :glb_id, references(:glbs, on_delete: :nothing)

      timestamps()
    end

    create index(:sounds, [:glb_id])
  end
end
