defmodule SoundgardenWeb.GlbModelController do
  use SoundgardenWeb, :controller

  alias Soundgarden.Archive
  alias Soundgarden.Archive.GlbModel

  def index(conn, _params) do
    glbs = Archive.list_glbs()
    render(conn, :index, glbs: glbs)
  end

  def new(conn, _params) do
    changeset = Archive.change_glb_model(%GlbModel{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"glb_model" => glb_model_params}) do
    case Archive.create_glb_model(glb_model_params) do
      {:ok, glb_model} ->
        conn
        |> put_flash(:info, "Glb models created successfully.")
        |> redirect(to: ~p"/glbs/#{glb_model}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    glb_model = Archive.get_glb_model!(id)
    render(conn, :show, glb_model: glb_model)
  end

  def edit(conn, %{"id" => id}) do
    glb_model = Archive.get_glb_model!(id)
    changeset = Archive.change_glb_model(glb_model)
    render(conn, :edit, glb_model: glb_model, changeset: changeset)
  end

  def update(conn, %{"id" => id, "glb_model" => glb_model_params}) do
    glb_model = Archive.get_glb_model!(id)

    case Archive.update_glb_model(glb_model, glb_model_params) do
      {:ok, glb_model} ->
        conn
        |> put_flash(:info, "Glb models updated successfully.")
        |> redirect(to: ~p"/glbs/#{glb_model}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, glb_model: glb_model, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    glb_model = Archive.get_glb_model!(id)
    {:ok, _glb_model} = Archive.delete_glb_model(glb_model)

    conn
    |> put_flash(:info, "Glb models deleted successfully.")
    |> redirect(to: ~p"/glbs")
  end
end
