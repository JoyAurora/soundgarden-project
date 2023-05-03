defmodule SoundgardenWeb.GlbModelControllerTest do
  use SoundgardenWeb.ConnCase

  import Soundgarden.ArchiveFixtures

  @create_attrs %{filename: "some filename"}
  @update_attrs %{filename: "some updated filename"}
  @invalid_attrs %{filename: nil}

  describe "index" do
    test "lists all glbs", %{conn: conn} do
      conn = get(conn, ~p"/glbs")
      assert html_response(conn, 200) =~ "Listing Glbs"
    end
  end

  describe "new glb_model" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/glbs/new")
      assert html_response(conn, 200) =~ "New Glb models"
    end
  end

  describe "create glb_model" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/glbs", glb_model: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/glbs/#{id}"

      conn = get(conn, ~p"/glbs/#{id}")
      assert html_response(conn, 200) =~ "Glb models #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/glbs", glb_model: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Glb models"
    end
  end

  describe "edit glb_model" do
    setup [:create_glb_model]

    test "renders form for editing chosen glb_model", %{conn: conn, glb_model: glb_model} do
      conn = get(conn, ~p"/glbs/#{glb_model}/edit")
      assert html_response(conn, 200) =~ "Edit Glb models"
    end
  end

  describe "update glb_model" do
    setup [:create_glb_model]

    test "redirects when data is valid", %{conn: conn, glb_model: glb_model} do
      conn = put(conn, ~p"/glbs/#{glb_model}", glb_model: @update_attrs)
      assert redirected_to(conn) == ~p"/glbs/#{glb_model}"

      conn = get(conn, ~p"/glbs/#{glb_model}")
      assert html_response(conn, 200) =~ "some updated filename"
    end

    test "renders errors when data is invalid", %{conn: conn, glb_model: glb_model} do
      conn = put(conn, ~p"/glbs/#{glb_model}", glb_model: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Glb models"
    end
  end

  describe "delete glb_model" do
    setup [:create_glb_model]

    test "deletes chosen glb_model", %{conn: conn, glb_model: glb_model} do
      conn = delete(conn, ~p"/glbs/#{glb_model}")
      assert redirected_to(conn) == ~p"/glbs"

      assert_error_sent 404, fn ->
        get(conn, ~p"/glbs/#{glb_model}")
      end
    end
  end

  defp create_glb_model(_) do
    glb_model = glb_model_fixture()
    %{glb_model: glb_model}
  end
end
