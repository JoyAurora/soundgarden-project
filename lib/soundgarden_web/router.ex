defmodule SoundgardenWeb.Router do
  use SoundgardenWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SoundgardenWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SoundgardenWeb do
    pipe_through :browser
    get "/", PageController, :home
    get "/instruments", PageController, :instruments
    get "/soundscapes", PageController, :soundscapes
    get "/admin", PageController, :admin
    get "/adminlogin", PageController, :adminlogin
    get "/images/:id/jpeg", ImageController, :jpeg
    get "/impulse_responses/:id/play", ImpulseResponseController, :play

    resources "/soundscapedata", PlaceController
    resources "/instrumentdata", InstrumentController
    resources "/places", PlaceController
    resources "/impulse_responses", ImpulseResponseController
    resources "/sounds", SoundController
    resources "/glbs", GlbModelController
    resources "/images", ImageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SoundgardenWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:soundgarden, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SoundgardenWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
