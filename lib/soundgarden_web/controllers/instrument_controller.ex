defmodule SoundgardenWeb.InstrumentController do
  use SoundgardenWeb, :controller

  alias Soundgarden.Archive
  alias Soundgarden.Archive.Instrument

  def index(conn, _params) do
    instruments = Archive.list_instruments()
    render(conn, :index, instruments: instruments)
  end

  def new(conn, _params) do
    changeset = Archive.change_instrument(%Instrument{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"instrument" => instrument_params}) do
    case Archive.create_instrument(instrument_params) do
      {:ok, instrument} ->
        conn
        |> put_flash(:info, "Instrument created successfully.")
        |> redirect(to: ~p"/instruments/#{instrument}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    instrument = Archive.get_instrument!(id)
    render(conn, :show, instrument: instrument)
  end

  def edit(conn, %{"id" => id}) do
    instrument = Archive.get_instrument!(id)
    changeset = Archive.change_instrument(instrument)
    render(conn, :edit, instrument: instrument, changeset: changeset)
  end

  def update(conn, %{"id" => id, "instrument" => instrument_params}) do
    instrument = Archive.get_instrument!(id)

    case Archive.update_instrument(instrument, instrument_params) do
      {:ok, instrument} ->
        conn
        |> put_flash(:info, "Instrument updated successfully.")
        |> redirect(to: ~p"/instruments/#{instrument}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, instrument: instrument, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    instrument = Archive.get_instrument!(id)
    {:ok, _instrument} = Archive.delete_instrument(instrument)

    conn
    |> put_flash(:info, "Instrument deleted successfully.")
    |> redirect(to: ~p"/instruments")
  end
end
