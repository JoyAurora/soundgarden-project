defmodule SoundgardenWeb.ImageHTML do
  use SoundgardenWeb, :html

  embed_templates "image_html/*"

  @doc """
  Renders an image form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :places, :list, default: []

  def image_form(assigns) do
    ~H"""
    <form action={@action} method="post">
      <!-- Form fields go here -->
      <label for="place">Select a Place:</label>
      <select name="place" id="place">
        <%= for place <- @places do %>
          <option value="<%= place.id %>"><%= place.name %></option>
        <% end %>
      </select>

      <%= submit "Save" %>
    </form>
    """
  end
end
