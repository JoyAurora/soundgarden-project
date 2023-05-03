defmodule SoundgardenWeb.PlaceController do
  use SoundgardenWeb, :controller

  alias Soundgarden.Archive

  def index(conn, _params) do
    places = Archive.list_places()
    render(conn, :index, places: places)
  end

  def new(conn, _params) do
    changeset = Soundgarden.Archive.change_place(%Soundgarden.Archive.Place{})
    image_changeset = Soundgarden.Archive.change_image(%Soundgarden.Archive.Image{})
    render(conn, "new.html", changeset: changeset, images: [image_changeset])
  end

  def create(conn, %{"place" => place_params}) do
    # Handle file uploads for images
    images_params = place_params["images"] || %{}
    images_params = Enum.map(images_params, fn {_, image_param} ->
      %Plug.Upload{path: temp_path, content_type: content_type, filename: filename} = image_param["file"]
      binary_data = File.read!(temp_path)
      %{
        "filename" => filename,
        "content_type" => content_type,
        "file" => binary_data
      }
    end)

    place_params = Map.put(place_params, "images", images_params)

    # Handle file uploads for impulse_responses
    impulse_response_params = place_params["impulse_response_params"] || %{}
    impulse_response_params = Enum.map(impulse_response_params, fn {_, impulse_response_param} ->
      %Plug.Upload{path: temp_path, content_type: content_type, filename: filename} = impulse_response_param["file"]
      binary_data = File.read!(temp_path)
      %{
        "filename" => filename,
        "content_type" => content_type,
        "file" => binary_data
      }
    end)

    place_params = Map.put(place_params, "impulse_responses", impulse_response_params)

    case Archive.create_place(place_params) do
      {:ok, place} ->
        conn
        |> put_flash(:info, "Place created successfully.")
        |> redirect(to: ~p"/places/#{place}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    place = Archive.get_place!(id)
    render(conn, :show, place: place)
  end

  def edit(conn, %{"id" => id}) do
    place = Archive.get_place!(id)
    changeset = Archive.change_place(place)
    render(conn, :edit, place: place, changeset: changeset,  images: place.images)
  end

  def update(conn, %{"id" => id, "place" => place_params}) do
    place = Archive.get_place!(id)

    images_params = place_params["images"] || %{}
    images_params = Enum.map(images_params, fn {_, image_param} ->
      case image_param["_delete"] do
        "1" -> nil
        _ ->
          case image_param["file"] do
            nil ->
              if image_param["id"] do
                existing_image = Enum.find(place.images, fn image -> image.id == String.to_integer(image_param["id"]) end)
                %{
                  "id" => image_param["id"],
                  "filename" => existing_image.filename,
                  "content_type" => existing_image.content_type,
                  "file" => existing_image.file
                }
              else
                nil
              end
            uploaded_file ->
              %Plug.Upload{path: temp_path, content_type: content_type, filename: filename} = uploaded_file
              binary_data = File.read!(temp_path)
              %{
                "filename" => filename,
                "content_type" => content_type,
                "file" => binary_data
              }
          end
      end
    end)

    images_params = Enum.reject(images_params, fn
      nil -> true
      {:skip, _id} -> true
      _ -> false
    end)

    impulse_params = place_params["impulse_responses"] || %{}
    impulse_params = Enum.map(impulse_params, fn {_, impulse_param} ->
      case impulse_param["_delete"] do
        "1" -> nil
        _ ->
          case impulse_param["file"] do
            nil -> nil
            uploaded_file ->
              %Plug.Upload{path: temp_path, content_type: content_type, filename: filename} = uploaded_file
              binary_data = File.read!(temp_path)
              %{
                "filename" => filename,
                "content_type" => content_type,
                "file" => binary_data
              }
          end
      end
    end)

    place_params = Map.put(place_params, "images", images_params)
    place_params = Map.put(place_params, "impulse_responses", impulse_params)

    case Archive.update_place_and_images(place, place_params) do
      {:ok, places} ->
        conn
        |> put_flash(:info, "Place updated successfully.")
        |> redirect(to: ~p"/places")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", place: place, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    place = Archive.get_place!(id)
    {:ok, _place} = Archive.delete_place(place)

    conn
    |> put_flash(:info, "Place deleted successfully.")
    |> redirect(to: ~p"/places")
  end
end
