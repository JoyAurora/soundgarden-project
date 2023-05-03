defmodule Soundgarden.Repo.Migrations.AddImageBinaryToImages do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add :bytes, :binary
      add :file_type, :string
    end
  end
end
