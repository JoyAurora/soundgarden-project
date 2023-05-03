defmodule Soundgarden.Archive.Place do
  use Ecto.Schema
  import Ecto.Changeset

  schema "places" do
    field :name, :string

    has_many :images, Soundgarden.Archive.Image, on_replace: :delete
    has_many :impulse_responses, Soundgarden.Archive.ImpulseResponse, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:images)
    |> cast_assoc(:impulse_responses)
  end
end
