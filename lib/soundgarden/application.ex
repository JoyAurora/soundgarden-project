defmodule Soundgarden.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SoundgardenWeb.Telemetry,
      # Start the Ecto repository
      Soundgarden.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Soundgarden.PubSub},
      # Start Finch
      {Finch, name: Soundgarden.Finch},
      # Start the Endpoint (http/https)
      SoundgardenWeb.Endpoint
      # Start a worker by calling: Soundgarden.Worker.start_link(arg)
      # {Soundgarden.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Soundgarden.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SoundgardenWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
