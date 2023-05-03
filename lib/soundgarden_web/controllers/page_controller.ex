defmodule SoundgardenWeb.PageController do
  use SoundgardenWeb, :controller
  alias Soundgarden.Archive

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home)
  end

  def admin(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :admin)
  end


  def instruments(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :instruments)
  end

  def soundscapes(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    places = Archive.list_places()
    render(conn, :soundscapes, places: places)
  end
end
