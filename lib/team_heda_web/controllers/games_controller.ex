defmodule TeamHedaWeb.GamesController do
  use TeamHedaWeb, :controller

  alias TeamHeda.{Game, Repo}

  def index(conn, _params) do
    games = Repo.all(Game)
    render(conn, "index.html", games: games)
  end

  def new(conn, _params) do
    alias TeamHeda.Game
    changeset = Game.changeset(%Game{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"game" => game_params}) do
    alias TeamHeda.Game
    alias TeamHeda.Repo
    %Game{}
    |> Game.changeset(game_params)
    |> Repo.insert
    |> case do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: Routes.games_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  def game_index(conn, %{"game_id" => game_id}) do
    game = Repo.get(Game, game_id)
    render(conn, "game-index.html", game: game)
  end

end
