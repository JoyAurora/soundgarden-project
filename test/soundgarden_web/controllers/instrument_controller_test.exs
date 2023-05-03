defmodule SoundgardenWeb.InstrumentControllerTest do
  use SoundgardenWeb.ConnCase

  import Soundgarden.ArchiveFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all instruments", %{conn: conn} do
      conn = get(conn, ~p"/instruments")
      assert html_response(conn, 200) =~ "Listing Instruments"
    end
  end

  describe "new instrument" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/instruments/new")
      assert html_response(conn, 200) =~ "New Instrument"
    end
  end

  describe "create instrument" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/instruments", instrument: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/instruments/#{id}"

      conn = get(conn, ~p"/instruments/#{id}")
      assert html_response(conn, 200) =~ "Instrument #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/instruments", instrument: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Instrument"
    end
  end

  describe "edit instrument" do
    setup [:create_instrument]

    test "renders form for editing chosen instrument", %{conn: conn, instrument: instrument} do
      conn = get(conn, ~p"/instruments/#{instrument}/edit")
      assert html_response(conn, 200) =~ "Edit Instrument"
    end
  end

  describe "update instrument" do
    setup [:create_instrument]

    test "redirects when data is valid", %{conn: conn, instrument: instrument} do
      conn = put(conn, ~p"/instruments/#{instrument}", instrument: @update_attrs)
      assert redirected_to(conn) == ~p"/instruments/#{instrument}"

      conn = get(conn, ~p"/instruments/#{instrument}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, instrument: instrument} do
      conn = put(conn, ~p"/instruments/#{instrument}", instrument: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Instrument"
    end
  end

  describe "delete instrument" do
    setup [:create_instrument]

    test "deletes chosen instrument", %{conn: conn, instrument: instrument} do
      conn = delete(conn, ~p"/instruments/#{instrument}")
      assert redirected_to(conn) == ~p"/instruments"

      assert_error_sent 404, fn ->
        get(conn, ~p"/instruments/#{instrument}")
      end
    end
  end

  defp create_instrument(_) do
    instrument = instrument_fixture()
    %{instrument: instrument}
  end
end
