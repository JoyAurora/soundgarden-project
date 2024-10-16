defmodule Soundgarden.Archive.ImpulseResponse do
  use Ecto.Schema
  import Ecto.Changeset

  schema "impulse_responses" do
    field :filename, :string
    field :file, :binary
    field :content_type, :string
    field :channel, :integer
    field :channel_name, :string
    belongs_to :place, Soundgarden.Archive.Place

    timestamps()
  end

  @doc false
  def changeset(impulse_response, attrs) do
    impulse_response
    |> cast(attrs, [:filename, :place_id, :file, :content_type, :channel, :channel_name])
    |> validate_required([:filename, :content_type, :file])
    |> validate_file_is_binary()
  end

  defp validate_file_is_binary(changeset) do
    if is_binary(get_field(changeset, :file)) do
      changeset
    else
      add_error(changeset, :file, "must be binary data")
    end
  end
end
