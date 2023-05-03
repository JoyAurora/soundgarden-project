defmodule SoundgardenWeb.GlbModelHTML do
  use SoundgardenWeb, :html

  embed_templates "glb_model_html/*"

  @doc """
  Renders a glb_model form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def glb_model_form(assigns)
end
