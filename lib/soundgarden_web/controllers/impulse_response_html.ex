defmodule SoundgardenWeb.ImpulseResponseHTML do
  use SoundgardenWeb, :html

  embed_templates "impulse_response_html/*"

  @doc """
  Renders a impulse_response form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def impulse_response_form(assigns)
end
