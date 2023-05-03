defmodule SoundgardenWeb.SoundController do
  use SoundgardenWeb, :controller

  alias Soundgarden.Archive
  alias Soundgarden.Archive.Sound

  def index(conn, _params) do
    sounds = Archive.list_sounds()
    render(conn, :index, sounds: sounds)
  end

  def new(conn, _params) do
    changeset = Archive.change_sound(%Sound{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"sound" => sound_params}) do
    case Archive.create_sound(sound_params) do
      {:ok, sound} ->
        conn
        |> put_flash(:info, "Sound created successfully.")
        |> redirect(to: ~p"/sounds/#{sound}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sound = Archive.get_sound!(id)
    render(conn, :show, sound: sound)
  end

  def edit(conn, %{"id" => id}) do
    sound = Archive.get_sound!(id)
    changeset = Archive.change_sound(sound)
    render(conn, :edit, sound: sound, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sound" => sound_params}) do
    sound = Archive.get_sound!(id)

    case Archive.update_sound(sound, sound_params) do
      {:ok, sound} ->
        conn
        |> put_flash(:info, "Sound updated successfully.")
        |> redirect(to: ~p"/sounds/#{sound}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, sound: sound, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sound = Archive.get_sound!(id)
    {:ok, _sound} = Archive.delete_sound(sound)

    conn
    |> put_flash(:info, "Sound deleted successfully.")
    |> redirect(to: ~p"/sounds")
  end
end
