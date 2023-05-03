defmodule Soundgarden.Repo.Migrations.CreateGlbs do
  use Ecto.Migration

  def change do
    create table(:glbs) do
      add :filename, :string
      add :instrument_id, references(:instruments, on_delete: :nothing)

      timestamps()
    end

    create index(:glbs, [:instrument_id])
  end
end
