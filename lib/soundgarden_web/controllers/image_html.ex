defmodule SoundgardenWeb.ImageHTML do
  use Phoenix.Component
  use SoundgardenWeb, :html

  @doc """
  Renders an edit form for images.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :places, :list, default: []

  def edit(assigns) do
    ~H"""
    <form action={@action} method="post">
      <!-- Example Form fields -->
      <label for="place">Select a Place:</label>
      <select name="place" id="place">
        <%= for place <- @places do %>
          <option value={place.id}><%= place.name %></option>
        <% end %>
      </select>

      <%= submit "Save" %>
    </form>
    """
  end
end
