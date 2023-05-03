defmodule Soundgarden.ArchiveFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Soundgarden.Archive` context.
  """

  @doc """
  Generate a place.
  """
  def place_fixture(attrs \\ %{}) do
    {:ok, place} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Soundgarden.Archive.create_place()

    place
  end

  @doc """
  Generate a instrument.
  """
  def instrument_fixture(attrs \\ %{}) do
    {:ok, instrument} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Soundgarden.Archive.create_instrument()

    instrument
  end

  @doc """
  Generate a glb_model.
  """
  def glb_model_fixture(attrs \\ %{}) do
    {:ok, glb_model} =
      attrs
      |> Enum.into(%{
        filename: "some filename"
      })
      |> Soundgarden.Archive.create_glb_model()

    glb_model
  end

  @doc """
  Generate a sound.
  """
  def sound_fixture(attrs \\ %{}) do
    {:ok, sound} =
      attrs
      |> Enum.into(%{
        filename: "some filename",
        object_name: "some object_name"
      })
      |> Soundgarden.Archive.create_sound()

    sound
  end

  @doc """
  Generate a image.
  """
  def image_fixture(attrs \\ %{}) do
    {:ok, image} =
      attrs
      |> Enum.into(%{
        filename: "some filename"
      })
      |> Soundgarden.Archive.create_image()

    image
  end

  @doc """
  Generate a impulse_response.
  """
  def impulse_response_fixture(attrs \\ %{}) do
    {:ok, impulse_response} =
      attrs
      |> Enum.into(%{
        filename: "some filename"
      })
      |> Soundgarden.Archive.create_impulse_response()

    impulse_response
  end
end
