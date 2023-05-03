defmodule Soundgarden.Repo.Migrations.CreateImpulseResponses do
  use Ecto.Migration

  def change do
    create table(:impulse_responses) do
      add :filename, :string
      add :place_id, references(:places, on_delete: :nothing)

      timestamps()
    end

    create index(:impulse_responses, [:place_id])
  end
end
