defmodule Soundgarden.Archive do
  @moduledoc """
  The Archive context.
  """

  import Ecto.Query, warn: false
  alias Soundgarden.Repo

  alias Soundgarden.Archive.Place
  alias Soundgarden.Archive.Image

  @doc """
  Updates a place and associated images.
  """
  def update_place_and_images(place, place_params) do
    Repo.transaction(fn ->
      updated_place =
        place
        |> Repo.preload(:images)
        |> Place.changeset(place_params)
        |> Repo.update!()

      images_params = place_params["images"] || []
      Enum.each(images_params, fn image_params ->
        case image_params["id"] do
          nil ->
            # Insert a new image
            %Image{}
            |> Image.changeset(image_params)
            |> Repo.insert!()
          id ->
            # Update an existing image
            image = Repo.get!(Image, id)
            image
            |> Image.changeset(image_params)
            |> Repo.update!()
        end
      end)

      # Explicitly return the updated place at the end of the transaction block
      updated_place
    end)
  end
end

# PlaceController with updated `update` function

defmodule SoundgardenWeb.PlaceController do
  use SoundgardenWeb, :controller

  alias Soundgarden.Archive

  def update(conn, %{"id" => id, "place" => place_params}) do
    place = Archive.get_place!(id)

    # Existing logic for processing images and impulse responses can be added here if needed

    case Archive.update_place_and_images(place, place_params) do
      {:ok, updated_place} ->
        # Simply render the "show" template for the updated place
        render(conn, :show, place: updated_place)

      {:error, %Ecto.Changeset{} = changeset} ->
        # In case of errors, render the edit form again with the current changeset
        render(conn, "edit.html", place: place, changeset: changeset)
    end
  end
end
