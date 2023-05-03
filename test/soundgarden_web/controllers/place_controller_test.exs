defmodule SoundgardenWeb.PlaceControllerTest do
  use SoundgardenWeb.ConnCase

  import Soundgarden.ArchiveFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all places", %{conn: conn} do
      conn = get(conn, ~p"/places")
      assert html_response(conn, 200) =~ "Listing Places"
    end
  end

  describe "new place" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/places/new")
      assert html_response(conn, 200) =~ "New Place"
    end
  end

  describe "create place" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/places", place: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/places/#{id}"

      conn = get(conn, ~p"/places/#{id}")
      assert html_response(conn, 200) =~ "Place #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/places", place: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Place"
    end
  end

  describe "edit place" do
    setup [:create_place]

    test "renders form for editing chosen place", %{conn: conn, place: place} do
      conn = get(conn, ~p"/places/#{place}/edit")
      assert html_response(conn, 200) =~ "Edit Place"
    end
  end

  describe "update place" do
    setup [:create_place]

    test "redirects when data is valid", %{conn: conn, place: place} do
      conn = put(conn, ~p"/places/#{place}", place: @update_attrs)
      assert redirected_to(conn) == ~p"/places/#{place}"

      conn = get(conn, ~p"/places/#{place}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, place: place} do
      conn = put(conn, ~p"/places/#{place}", place: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Place"
    end
  end

  describe "delete place" do
    setup [:create_place]

    test "deletes chosen place", %{conn: conn, place: place} do
      conn = delete(conn, ~p"/places/#{place}")
      assert redirected_to(conn) == ~p"/places"

      assert_error_sent 404, fn ->
        get(conn, ~p"/places/#{place}")
      end
    end
  end

  defp create_place(_) do
    place = place_fixture()
    %{place: place}
  end
end
