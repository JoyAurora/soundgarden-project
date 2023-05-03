defmodule Soundgarden.Archive.Sound do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sounds" do
    field :filename, :string
    field :object_name, :string
    field :glb_id, :id

    timestamps()
  end

  @doc false
  def changeset(sound, attrs) do
    sound
    |> cast(attrs, [:filename, :object_name])
    |> validate_required([:filename, :object_name])
  end
end
