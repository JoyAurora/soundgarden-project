defmodule Soundgarden.Repo.Migrations.RenameImageBytesToFile do
  use Ecto.Migration

  def change do
    rename table(:images), :bytes, to: :file
  end
end
