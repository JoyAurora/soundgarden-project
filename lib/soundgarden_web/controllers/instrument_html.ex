defmodule SoundgardenWeb.InstrumentHTML do
  use SoundgardenWeb, :html

  embed_templates "instrument_html/*"

  @doc """
  Renders a instrument form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def instrument_form(assigns)
end
