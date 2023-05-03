defmodule Soundgarden.Repo.Migrations.ChangeImagesFileTypeToContentType do
  use Ecto.Migration

  def change do
    rename table(:images), :file_type, to: :content_type
  end
end
