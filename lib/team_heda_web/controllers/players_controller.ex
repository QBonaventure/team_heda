defmodule TeamHedaWeb.PlayersController do
  use TeamHedaWeb, :controller

  alias TeamHeda.{Repo,Player}

  plug :scrub_params, "player" when action in [:register]

  def register(conn, %{"player" => player_params}) do
    changeset =
      %Player{}
      |> Player.registration_changeset(player_params)

    case Repo.insert(changeset) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "#{player.name} created!")
        |> redirect(to: Routes.players_path(conn, :player_index, player))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
     end
   end

end
