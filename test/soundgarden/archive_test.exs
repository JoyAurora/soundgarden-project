defmodule Soundgarden.ArchiveTest do
  use Soundgarden.DataCase

  alias Soundgarden.Archive

  describe "places" do
    alias Soundgarden.Archive.Place

    import Soundgarden.ArchiveFixtures

    @invalid_attrs %{name: nil}

    test "list_places/0 returns all places" do
      place = place_fixture()
      assert Archive.list_places() == [place]
    end

    test "get_place!/1 returns the place with given id" do
      place = place_fixture()
      assert Archive.get_place!(place.id) == place
    end

    test "create_place/1 with valid data creates a place" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Place{} = place} = Archive.create_place(valid_attrs)
      assert place.name == "some name"
    end

    test "create_place/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Archive.create_place(@invalid_attrs)
    end

    test "update_place/2 with valid data updates the place" do
      place = place_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Place{} = place} = Archive.update_place(place, update_attrs)
      assert place.name == "some updated name"
    end

    test "update_place/2 with invalid data returns error changeset" do
      place = place_fixture()
      assert {:error, %Ecto.Changeset{}} = Archive.update_place(place, @invalid_attrs)
      assert place == Archive.get_place!(place.id)
    end

    test "delete_place/1 deletes the place" do
      place = place_fixture()
      assert {:ok, %Place{}} = Archive.delete_place(place)
      assert_raise Ecto.NoResultsError, fn -> Archive.get_place!(place.id) end
    end

    test "change_place/1 returns a place changeset" do
      place = place_fixture()
      assert %Ecto.Changeset{} = Archive.change_place(place)
    end
  end

  describe "instruments" do
    alias Soundgarden.Archive.Instrument

    import Soundgarden.ArchiveFixtures

    @invalid_attrs %{name: nil}

    test "list_instruments/0 returns all instruments" do
      instrument = instrument_fixture()
      assert Archive.list_instruments() == [instrument]
    end

    test "get_instrument!/1 returns the instrument with given id" do
      instrument = instrument_fixture()
      assert Archive.get_instrument!(instrument.id) == instrument
    end

    test "create_instrument/1 with valid data creates a instrument" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Instrument{} = instrument} = Archive.create_instrument(valid_attrs)
      assert instrument.name == "some name"
    end

    test "create_instrument/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Archive.create_instrument(@invalid_attrs)
    end

    test "update_instrument/2 with valid data updates the instrument" do
      instrument = instrument_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Instrument{} = instrument} = Archive.update_instrument(instrument, update_attrs)
      assert instrument.name == "some updated name"
    end

    test "update_instrument/2 with invalid data returns error changeset" do
      instrument = instrument_fixture()
      assert {:error, %Ecto.Changeset{}} = Archive.update_instrument(instrument, @invalid_attrs)
      assert instrument == Archive.get_instrument!(instrument.id)
    end

    test "delete_instrument/1 deletes the instrument" do
      instrument = instrument_fixture()
      assert {:ok, %Instrument{}} = Archive.delete_instrument(instrument)
      assert_raise Ecto.NoResultsError, fn -> Archive.get_instrument!(instrument.id) end
    end

    test "change_instrument/1 returns a instrument changeset" do
      instrument = instrument_fixture()
      assert %Ecto.Changeset{} = Archive.change_instrument(instrument)
    end
  end

  describe "glbs" do
    alias Soundgarden.Archive.GlbModel

    import Soundgarden.ArchiveFixtures

    @invalid_attrs %{filename: nil}

    test "list_glbs/0 returns all glbs" do
      glb_model = glb_model_fixture()
      assert Archive.list_glbs() == [glb_model]
    end

    test "get_glb_model!/1 returns the glb_model with given id" do
      glb_model = glb_model_fixture()
      assert Archive.get_glb_model!(glb_model.id) == glb_model
    end

    test "create_glb_model/1 with valid data creates a glb_model" do
      valid_attrs = %{filename: "some filename"}

      assert {:ok, %GlbModel{} = glb_model} = Archive.create_glb_model(valid_attrs)
      assert glb_model.filename == "some filename"
    end

    test "create_glb_model/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Archive.create_glb_model(@invalid_attrs)
    end

    test "update_glb_model/2 with valid data updates the glb_model" do
      glb_model = glb_model_fixture()
      update_attrs = %{filename: "some updated filename"}

      assert {:ok, %GlbModel{} = glb_model} = Archive.update_glb_model(glb_model, update_attrs)
      assert glb_model.filename == "some updated filename"
    end

    test "update_glb_model/2 with invalid data returns error changeset" do
      glb_model = glb_model_fixture()
      assert {:error, %Ecto.Changeset{}} = Archive.update_glb_model(glb_model, @invalid_attrs)
      assert glb_model == Archive.get_glb_model!(glb_model.id)
    end

    test "delete_glb_model/1 deletes the glb_model" do
      glb_model = glb_model_fixture()
      assert {:ok, %GlbModel{}} = Archive.delete_glb_model(glb_model)
      assert_raise Ecto.NoResultsError, fn -> Archive.get_glb_model!(glb_model.id) end
    end

    test "change_glb_model/1 returns a glb_model changeset" do
      glb_model = glb_model_fixture()
      assert %Ecto.Changeset{} = Archive.change_glb_model(glb_model)
    end
  end

  describe "sounds" do
    alias Soundgarden.Archive.Sound

    import Soundgarden.ArchiveFixtures

    @invalid_attrs %{filename: nil, object_name: nil}

    test "list_sounds/0 returns all sounds" do
      sound = sound_fixture()
      assert Archive.list_sounds() == [sound]
    end

    test "get_sound!/1 returns the sound with given id" do
      sound = sound_fixture()
      assert Archive.get_sound!(sound.id) == sound
    end

    test "create_sound/1 with valid data creates a sound" do
      valid_attrs = %{filename: "some filename", object_name: "some object_name"}

      assert {:ok, %Sound{} = sound} = Archive.create_sound(valid_attrs)
      assert sound.filename == "some filename"
      assert sound.object_name == "some object_name"
    end

    test "create_sound/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Archive.create_sound(@invalid_attrs)
    end

    test "update_sound/2 with valid data updates the sound" do
      sound = sound_fixture()
      update_attrs = %{filename: "some updated filename", object_name: "some updated object_name"}

      assert {:ok, %Sound{} = sound} = Archive.update_sound(sound, update_attrs)
      assert sound.filename == "some updated filename"
      assert sound.object_name == "some updated object_name"
    end

    test "update_sound/2 with invalid data returns error changeset" do
      sound = sound_fixture()
      assert {:error, %Ecto.Changeset{}} = Archive.update_sound(sound, @invalid_attrs)
      assert sound == Archive.get_sound!(sound.id)
    end

    test "delete_sound/1 deletes the sound" do
      sound = sound_fixture()
      assert {:ok, %Sound{}} = Archive.delete_sound(sound)
      assert_raise Ecto.NoResultsError, fn -> Archive.get_sound!(sound.id) end
    end

    test "change_sound/1 returns a sound changeset" do
      sound = sound_fixture()
      assert %Ecto.Changeset{} = Archive.change_sound(sound)
    end
  end

  describe "images" do
    alias Soundgarden.Archive.Image

    import Soundgarden.ArchiveFixtures

    @invalid_attrs %{filename: nil}

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Archive.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Archive.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      valid_attrs = %{filename: "some filename"}

      assert {:ok, %Image{} = image} = Archive.create_image(valid_attrs)
      assert image.filename == "some filename"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Archive.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      update_attrs = %{filename: "some updated filename"}

      assert {:ok, %Image{} = image} = Archive.update_image(image, update_attrs)
      assert image.filename == "some updated filename"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Archive.update_image(image, @invalid_attrs)
      assert image == Archive.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Archive.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Archive.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Archive.change_image(image)
    end
  end

  describe "impulse_responses" do
    alias Soundgarden.Archive.ImpulseResponse

    import Soundgarden.ArchiveFixtures

    @invalid_attrs %{filename: nil}

    test "list_impulse_responses/0 returns all impulse_responses" do
      impulse_response = impulse_response_fixture()
      assert Archive.list_impulse_responses() == [impulse_response]
    end

    test "get_impulse_response!/1 returns the impulse_response with given id" do
      impulse_response = impulse_response_fixture()
      assert Archive.get_impulse_response!(impulse_response.id) == impulse_response
    end

    test "create_impulse_response/1 with valid data creates a impulse_response" do
      valid_attrs = %{filename: "some filename"}

      assert {:ok, %ImpulseResponse{} = impulse_response} = Archive.create_impulse_response(valid_attrs)
      assert impulse_response.filename == "some filename"
    end

    test "create_impulse_response/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Archive.create_impulse_response(@invalid_attrs)
    end

    test "update_impulse_response/2 with valid data updates the impulse_response" do
      impulse_response = impulse_response_fixture()
      update_attrs = %{filename: "some updated filename"}

      assert {:ok, %ImpulseResponse{} = impulse_response} = Archive.update_impulse_response(impulse_response, update_attrs)
      assert impulse_response.filename == "some updated filename"
    end

    test "update_impulse_response/2 with invalid data returns error changeset" do
      impulse_response = impulse_response_fixture()
      assert {:error, %Ecto.Changeset{}} = Archive.update_impulse_response(impulse_response, @invalid_attrs)
      assert impulse_response == Archive.get_impulse_response!(impulse_response.id)
    end

    test "delete_impulse_response/1 deletes the impulse_response" do
      impulse_response = impulse_response_fixture()
      assert {:ok, %ImpulseResponse{}} = Archive.delete_impulse_response(impulse_response)
      assert_raise Ecto.NoResultsError, fn -> Archive.get_impulse_response!(impulse_response.id) end
    end

    test "change_impulse_response/1 returns a impulse_response changeset" do
      impulse_response = impulse_response_fixture()
      assert %Ecto.Changeset{} = Archive.change_impulse_response(impulse_response)
    end
  end
end
