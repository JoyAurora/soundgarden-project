defmodule Soundgarden.Repo.Migrations.ModifySounds do
  use Ecto.Migration

  def change do
    alter table(:sounds) do
      add :file, :binary
      add :content_type, :string
    end
  end
end
