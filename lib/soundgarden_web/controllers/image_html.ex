defmodule SoundgardenWeb.ImageHTML do
  use SoundgardenWeb, :html

  # Define all attributes before the first function or macro
  @doc """
  Renders an image form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :places, :list, default: []

  # After the attribute definitions, you can call embed_templates
  embed_templates "image_html/*"

  # Define your function
  def image_form(assigns) do
    ~H"""
    <form action={@action} method="post">
      <!-- Example Form fields -->
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
