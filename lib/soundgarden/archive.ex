defmodule Soundgarden.Archive do
  @moduledoc """
  The Archive context.
  """

  import Ecto.Query, warn: false
  alias Soundgarden.Repo

  alias Soundgarden.Archive.Place
  alias Soundgarden.Archive.Image

  @doc """
  Returns the list of places.

  ## Examples

      iex> list_places()
      [%Place{}, ...]

  """
  def list_places do
    Place
    |> Repo.all()
    |> Repo.preload(:images)
    |> Repo.preload(:impulse_responses)
  end

  @doc """
  Gets a single place.

  Raises `Ecto.NoResultsError` if the Place does not exist.

  ## Examples

      iex> get_place!(123)
      %Place{}

      iex> get_place!(456)
      ** (Ecto.NoResultsError)

  """
  def get_place!(id) do
    Repo.get!(Place, id)
    |> Repo.preload(:images)
  end

  def get_place_wth_impulse_resonses!(id) do
    Repo.get!(Place, id)
    |> Repo.preload(:images)
    |> Repo.preload(:impulse_responses)
  end

  @doc """
  """
  def get_place_with_images!(id), do: Repo.get!(Place, id) |> Repo.preload(:images)

  @doc """
  Creates a place.

  ## Examples

      iex> create_place(%{field: value})
      {:ok, %Place{}}

      iex> create_place(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_place(attrs \\ %{}) do
    %Place{}
    |> Place.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a place.

  ## Examples

      iex> update_place(place, %{field: new_value})
      {:ok, %Place{}}

      iex> update_place(place, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_place(%Place{} = place, attrs) do
    place
    |> Place.changeset(attrs)
    |> Repo.update()
  end

  def update_place_and_images(place, place_params) do
    Repo.transaction(fn ->
      place
      |> Repo.preload(:images)
      |> Place.changeset(place_params)
      |> Repo.update!()

      images_params = place_params["images"]
      Enum.each(images_params, fn image_params ->
        case image_params["id"] do
          nil ->
            # Insert a new image
            %Image{}
            |> Image.changeset(image_params)
            |> Repo.insert!()
          id ->
            # Update an existing image
            image = Repo.get!(Image, id)
            image
            |> Image.changeset(image_params)
            |> Repo.update!()
        end
      end)
    end)
  end

  @doc """
  Deletes a place.

  ## Examples

      iex> delete_place(place)
      {:ok, %Place{}}

      iex> delete_place(place)
      {:error, %Ecto.Changeset{}}

  """
  def delete_place(%Place{} = place) do
    Repo.delete(place)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking place changes.

  ## Examples

      iex> change_place(place)
      %Ecto.Changeset{data: %Place{}}

  """
  def change_place(%Place{} = place, attrs \\ %{}) do
    Place.changeset(place, attrs)
  end

  alias Soundgarden.Archive.Instrument

  @doc """
  Returns the list of instruments.

  ## Examples

      iex> list_instruments()
      [%Instrument{}, ...]

  """
  def list_instruments do
    Repo.all(Instrument)
  end

  @doc """
  Gets a single instrument.

  Raises `Ecto.NoResultsError` if the Instrument does not exist.

  ## Examples

      iex> get_instrument!(123)
      %Instrument{}

      iex> get_instrument!(456)
      ** (Ecto.NoResultsError)

  """
  def get_instrument!(id), do: Repo.get!(Instrument, id)

  @doc """
  Creates a instrument.

  ## Examples

      iex> create_instrument(%{field: value})
      {:ok, %Instrument{}}

      iex> create_instrument(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_instrument(attrs \\ %{}) do
    %Instrument{}
    |> Instrument.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a instrument.

  ## Examples

      iex> update_instrument(instrument, %{field: new_value})
      {:ok, %Instrument{}}

      iex> update_instrument(instrument, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_instrument(%Instrument{} = instrument, attrs) do
    instrument
    |> Instrument.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a instrument.

  ## Examples

      iex> delete_instrument(instrument)
      {:ok, %Instrument{}}

      iex> delete_instrument(instrument)
      {:error, %Ecto.Changeset{}}

  """
  def delete_instrument(%Instrument{} = instrument) do
    Repo.delete(instrument)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking instrument changes.

  ## Examples

      iex> change_instrument(instrument)
      %Ecto.Changeset{data: %Instrument{}}

  """
  def change_instrument(%Instrument{} = instrument, attrs \\ %{}) do
    Instrument.changeset(instrument, attrs)
  end

  alias Soundgarden.Archive.GlbModel

  @doc """
  Returns the list of glbs.

  ## Examples

      iex> list_glbs()
      [%GlbModel{}, ...]

  """
  def list_glbs do
    Repo.all(GlbModel)
  end

  @doc """
  Gets a single glb_model.

  Raises `Ecto.NoResultsError` if the Glb models does not exist.

  ## Examples

      iex> get_glb_model!(123)
      %GlbModel{}

      iex> get_glb_model!(456)
      ** (Ecto.NoResultsError)

  """
  def get_glb_model!(id), do: Repo.get!(GlbModel, id)

  @doc """
  Creates a glb_model.

  ## Examples

      iex> create_glb_model(%{field: value})
      {:ok, %GlbModel{}}

      iex> create_glb_model(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_glb_model(attrs \\ %{}) do
    %GlbModel{}
    |> GlbModel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a glb_model.

  ## Examples

      iex> update_glb_model(glb_model, %{field: new_value})
      {:ok, %GlbModel{}}

      iex> update_glb_model(glb_model, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_glb_model(%GlbModel{} = glb_model, attrs) do
    glb_model
    |> GlbModel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a glb_model.

  ## Examples

      iex> delete_glb_model(glb_model)
      {:ok, %GlbModel{}}

      iex> delete_glb_model(glb_model)
      {:error, %Ecto.Changeset{}}

  """
  def delete_glb_model(%GlbModel{} = glb_model) do
    Repo.delete(glb_model)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking glb_model changes.

  ## Examples

      iex> change_glb_model(glb_model)
      %Ecto.Changeset{data: %GlbModel{}}

  """
  def change_glb_model(%GlbModel{} = glb_model, attrs \\ %{}) do
    GlbModel.changeset(glb_model, attrs)
  end

  alias Soundgarden.Archive.Sound

  @doc """
  Returns the list of sounds.

  ## Examples

      iex> list_sounds()
      [%Sound{}, ...]

  """
  def list_sounds do
    Repo.all(Sound)
  end

  @doc """
  Gets a single sound.

  Raises `Ecto.NoResultsError` if the Sound does not exist.

  ## Examples

      iex> get_sound!(123)
      %Sound{}

      iex> get_sound!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sound!(id), do: Repo.get!(Sound, id)

  @doc """
  Creates a sound.

  ## Examples

      iex> create_sound(%{field: value})
      {:ok, %Sound{}}

      iex> create_sound(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sound(attrs \\ %{}) do
    %Sound{}
    |> Sound.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sound.

  ## Examples

      iex> update_sound(sound, %{field: new_value})
      {:ok, %Sound{}}

      iex> update_sound(sound, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sound(%Sound{} = sound, attrs) do
    sound
    |> Sound.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sound.

  ## Examples

      iex> delete_sound(sound)
      {:ok, %Sound{}}

      iex> delete_sound(sound)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sound(%Sound{} = sound) do
    Repo.delete(sound)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sound changes.

  ## Examples

      iex> change_sound(sound)
      %Ecto.Changeset{data: %Sound{}}

  """
  def change_sound(%Sound{} = sound, attrs \\ %{}) do
    Sound.changeset(sound, attrs)
  end

  alias Soundgarden.Archive.Image

  @doc """
  Returns the list of images.

  ## Examples

      iex> list_images()
      [%Image{}, ...]

  """
  def list_images do
    Image
    |> Repo.all()
    |> Repo.preload(:place)
  end

  @doc """
  Gets a single image.

  Raises `Ecto.NoResultsError` if the Image does not exist.

  ## Examples

      iex> get_image!(123)
      %Image{}

      iex> get_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image!(id), do: Repo.get!(Image, id)

  @doc """
  Creates a image.

  ## Examples

      iex> create_image(%{field: value})
      {:ok, %Image{}}

      iex> create_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a image.

  ## Examples

      iex> update_image(image, %{field: new_value})
      {:ok, %Image{}}

      iex> update_image(image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a image.

  ## Examples

      iex> delete_image(image)
      {:ok, %Image{}}

      iex> delete_image(image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image(%Image{} = image) do
    Repo.delete(image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image changes.

  ## Examples

      iex> change_image(image)
      %Ecto.Changeset{data: %Image{}}

  """
  def change_image(%Image{} = image, attrs \\ %{}) do
    Image.changeset(image, attrs)
  end

  alias Soundgarden.Archive.ImpulseResponse

  @doc """
  Returns the list of impulse_responses.

  ## Examples

      iex> list_impulse_responses()
      [%ImpulseResponse{}, ...]

  """
  def list_impulse_responses do
    Repo.all(ImpulseResponse)
  end

  @doc """
  Gets a single impulse_response.

  Raises `Ecto.NoResultsError` if the Impulse response does not exist.

  ## Examples

      iex> get_impulse_response!(123)
      %ImpulseResponse{}

      iex> get_impulse_response!(456)
      ** (Ecto.NoResultsError)

  """
  def get_impulse_response!(id), do: Repo.get!(ImpulseResponse, id)

  @doc """
  Creates a impulse_response.

  ## Examples

      iex> create_impulse_response(%{field: value})
      {:ok, %ImpulseResponse{}}

      iex> create_impulse_response(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_impulse_response(attrs \\ %{}) do
    %ImpulseResponse{}
    |> ImpulseResponse.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a impulse_response.

  ## Examples

      iex> update_impulse_response(impulse_response, %{field: new_value})
      {:ok, %ImpulseResponse{}}

      iex> update_impulse_response(impulse_response, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_impulse_response(%ImpulseResponse{} = impulse_response, attrs) do
    impulse_response
    |> ImpulseResponse.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a impulse_response.

  ## Examples

      iex> delete_impulse_response(impulse_response)
      {:ok, %ImpulseResponse{}}

      iex> delete_impulse_response(impulse_response)
      {:error, %Ecto.Changeset{}}

  """
  def delete_impulse_response(%ImpulseResponse{} = impulse_response) do
    Repo.delete(impulse_response)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking impulse_response changes.

  ## Examples

      iex> change_impulse_response(impulse_response)
      %Ecto.Changeset{data: %ImpulseResponse{}}

  """
  def change_impulse_response(%ImpulseResponse{} = impulse_response, attrs \\ %{}) do
    ImpulseResponse.changeset(impulse_response, attrs)
  end
end
