defmodule SoundgardenWeb.ImpulseResponseControllerTest do
  use SoundgardenWeb.ConnCase

  import Soundgarden.ArchiveFixtures

  @create_attrs %{filename: "some filename"}
  @update_attrs %{filename: "some updated filename"}
  @invalid_attrs %{filename: nil}

  describe "index" do
    test "lists all impulse_responses", %{conn: conn} do
      conn = get(conn, ~p"/impulse_responses")
      assert html_response(conn, 200) =~ "Listing Impulse responses"
    end
  end

  describe "new impulse_response" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/impulse_responses/new")
      assert html_response(conn, 200) =~ "New Impulse response"
    end
  end

  describe "create impulse_response" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/impulse_responses", impulse_response: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/impulse_responses/#{id}"

      conn = get(conn, ~p"/impulse_responses/#{id}")
      assert html_response(conn, 200) =~ "Impulse response #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/impulse_responses", impulse_response: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Impulse response"
    end
  end

  describe "edit impulse_response" do
    setup [:create_impulse_response]

    test "renders form for editing chosen impulse_response", %{conn: conn, impulse_response: impulse_response} do
      conn = get(conn, ~p"/impulse_responses/#{impulse_response}/edit")
      assert html_response(conn, 200) =~ "Edit Impulse response"
    end
  end

  describe "update impulse_response" do
    setup [:create_impulse_response]

    test "redirects when data is valid", %{conn: conn, impulse_response: impulse_response} do
      conn = put(conn, ~p"/impulse_responses/#{impulse_response}", impulse_response: @update_attrs)
      assert redirected_to(conn) == ~p"/impulse_responses/#{impulse_response}"

      conn = get(conn, ~p"/impulse_responses/#{impulse_response}")
      assert html_response(conn, 200) =~ "some updated filename"
    end

    test "renders errors when data is invalid", %{conn: conn, impulse_response: impulse_response} do
      conn = put(conn, ~p"/impulse_responses/#{impulse_response}", impulse_response: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Impulse response"
    end
  end

  describe "delete impulse_response" do
    setup [:create_impulse_response]

    test "deletes chosen impulse_response", %{conn: conn, impulse_response: impulse_response} do
      conn = delete(conn, ~p"/impulse_responses/#{impulse_response}")
      assert redirected_to(conn) == ~p"/impulse_responses"

      assert_error_sent 404, fn ->
        get(conn, ~p"/impulse_responses/#{impulse_response}")
      end
    end
  end

  defp create_impulse_response(_) do
    impulse_response = impulse_response_fixture()
    %{impulse_response: impulse_response}
  end
end
