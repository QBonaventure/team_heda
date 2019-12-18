defmodule TeamHedaWeb.Router do
  use TeamHedaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TeamHedaWeb do
    pipe_through :browser

    get "/", PageController, :index


    live "/me", PlayerProfileLive, session: [:current_user]
    live "/teams/:id/manager", TeamManagerLive, session: [:current_user]


    get "/teams", TeamsController, :index
    get "/teams/:team_id", TeamsController, :team_index

    get "/games", GamesController, :index
    get "/games/new", GamesController, :new
    post "/games", GamesController, :create
    get "/games/:game_id", GamesController, :game_index

    get "/players/:player_name", PlayersController, :player_index
    get "/login", PlayersController, :player_login
    get "/register", PlayersController, :register

    get "/logout", AuthController, :logout
    get "/auth/:service/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", TeamHedaWeb do
  #   pipe_through :api
  # end
end
