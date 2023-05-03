defmodule SoundgardenWeb.ImpulseResponseController do
  use SoundgardenWeb, :controller

  alias Soundgarden.Archive
  alias Soundgarden.Archive.ImpulseResponse

  def index(conn, _params) do
    impulse_responses = Archive.list_impulse_responses()
    render(conn, :index, impulse_responses: impulse_responses)
  end

  def new(conn, _params) do
    changeset = Archive.change_impulse_response(%ImpulseResponse{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"impulse_response" => impulse_response_params}) do
    case Archive.create_impulse_response(impulse_response_params) do
      {:ok, impulse_response} ->
        conn
        |> put_flash(:info, "Impulse response created successfully.")
        |> redirect(to: ~p"/impulse_responses/#{impulse_response}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def play(conn, %{"id" => id}) do
    ir = Archive.get_impulse_response!(id)
    binary_data = ir.file
    content_type = ir.content_type

    conn
    |> put_resp_content_type(content_type)
    |> send_resp(200, binary_data)
  end

  def show(conn, %{"id" => id}) do
    impulse_response = Archive.get_impulse_response!(id)
    render(conn, :show, impulse_response: impulse_response)
  end

  def edit(conn, %{"id" => id}) do
    impulse_response = Archive.get_impulse_response!(id)
    changeset = Archive.change_impulse_response(impulse_response)
    render(conn, :edit, impulse_response: impulse_response, changeset: changeset)
  end

  def update(conn, %{"id" => id, "impulse_response" => impulse_response_params}) do
    impulse_response = Archive.get_impulse_response!(id)

    case Archive.update_impulse_response(impulse_response, impulse_response_params) do
      {:ok, impulse_response} ->
        conn
        |> put_flash(:info, "Impulse response updated successfully.")
        |> redirect(to: ~p"/impulse_responses/#{impulse_response}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, impulse_response: impulse_response, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    impulse_response = Archive.get_impulse_response!(id)
    {:ok, _impulse_response} = Archive.delete_impulse_response(impulse_response)

    conn
    |> put_flash(:info, "Impulse response deleted successfully.")
    |> redirect(to: ~p"/impulse_responses")
  end
end
