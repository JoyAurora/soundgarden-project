defmodule Soundgarden.Repo do
  use Ecto.Repo,
    otp_app: :soundgarden,
    adapter: Ecto.Adapters.Postgres
end
