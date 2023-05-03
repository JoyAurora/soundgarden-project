defmodule Soundgarden.Archive.Instrument do
  use Ecto.Schema
  import Ecto.Changeset

  schema "instruments" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(instrument, attrs) do
    instrument
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
