defmodule Soundgarden.Repo.Migrations.UpdateImpulseResponses do
  use Ecto.Migration

  def change do
    drop constraint(:impulse_responses, :impulse_responses_place_id_fkey)
    alter table(:impulse_responses) do
      add :file, :binary
      add :content_type, :string
      add :channel_name, :string
      add :channel, :int
      
      modify :place_id, references(:places, on_delete: :delete_all)
    end
  end
end
