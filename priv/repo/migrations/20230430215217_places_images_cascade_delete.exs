defmodule Soundgarden.Repo.Migrations.PlacesImagesCascadeDelete do
  use Ecto.Migration

  def change do
    drop constraint(:images, :images_place_id_fkey)
    alter table(:images) do
      modify :place_id, references(:places, on_delete: :delete_all)
    end
  end
end
