defmodule Soundgarden.Archive.GlbModel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "glbs" do
    field :filename, :string
    field :instrument_id, :id

    timestamps()
  end

  @doc false
  def changeset(glb_model, attrs) do
    glb_model
    |> cast(attrs, [:filename])
    |> validate_required([:filename])
  end
end
