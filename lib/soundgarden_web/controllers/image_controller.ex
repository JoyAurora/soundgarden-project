defmodule SoundgardenWeb.ImageController do
  use SoundgardenWeb, :controller

  alias Soundgarden.Archive
  alias Soundgarden.Archive.Image

  def index(conn, _params) do
    images = Archive.list_images()
    render(conn, :index, images: images)
  end

  def new(conn, _params) do
    changeset = Archive.change_image(%Image{})
    places = Archive.list_places()
    render(conn, :new, changeset: changeset, places: places)
  end

  def create(conn, %{"image" => image_params}) do
    %Plug.Upload{path: temp_path, content_type: content_type, filename: filename} = Map.get(image_params, "file")
    binary_data = File.read!(temp_path)

    image_params = %{
      "filename" => filename,
      "content_type" => content_type,
      "file" => binary_data,
      "place_id" => image_params["place_id"],
      "name" => image_params["name"]
    }

    case Archive.create_image(image_params) do
      {:ok, image} ->
        IO.inspect image_params

        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: ~p"/images/#{image}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Archive.get_image!(id)
    binary_data = image.file
    content_type = image.content_type
    render(conn, :show, image: image, binary_data: binary_data, content_type: content_type)
  end

  def jpeg(conn, %{"id" => id}) do
    image = Archive.get_image!(id)
    binary_data = image.file
    content_type = image.content_type

    conn
    |> put_resp_content_type(content_type)
    |> send_resp(200, binary_data)
  end

  def edit(conn, %{"id" => id}) do
    image = Archive.get_image!(id)
    changeset = Archive.change_image(image)
    render(conn, :edit, image: image, changeset: changeset)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = Archive.get_image!(id)

    case Archive.update_image(image, image_params) do
      {:ok, image} ->
        conn
        |> put_flash(:info, "Image updated successfully.")
        |> redirect(to: ~p"/images/#{image}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, image: image, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Archive.get_image!(id)
    {:ok, _image} = Archive.delete_image(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: ~p"/images")
  end
end
