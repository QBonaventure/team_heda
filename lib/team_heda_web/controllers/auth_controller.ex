defmodule TeamHedaWeb.AuthController do
  use TeamHedaWeb, :controller
  alias TeamHeda.{Repo,UserSession,Player,PlayerExternalAccount,ExternalService}
  alias TeamHeda.ExternalService.{Maniaplanet,Discord}
  import Ecto.Query

  def callback(conn, %{"code" => code, "service" => "discord"}) do
    client = Discord.get_token!([code: code])
    %{username: username} = Discord.get_user(client.token)
    service_id = Repo.get_by(ExternalService, name: "Discord").id

    set_user_session(conn, service_id, username)
  end


  def callback(conn, %{"code" => code, "service" => "maniaplanet", "state" => _state}) do
    client = Maniaplanet.get_token!([code: code])
    %{username: username} = Maniaplanet.get_user(client.token)
    service_id = Repo.get_by(ExternalService, name: "Maniaplanet").id

    player_query = from(p in Player,
      join: a in PlayerExternalAccount,
      on: p.id == a.player_id,
      where: a.service_id == ^service_id and a.username == ^username)

    {player, message} = case Repo.exists?(player_query) do
      false ->
        {:ok, player} =
          %Player{}
          |> Player.change_new(%{name: username, service_id: service_id})
          |> Repo.insert
        %PlayerExternalAccount{}
        |> PlayerExternalAccount.change_new(%{player_id: player.id, service_id: service_id, username: username})
        |> Repo.insert
        {UserSession.from_player(player), "Hello #{player.name}! Looks like your first time connection. Don't hesitate to edit your info here!"}
      true ->
        user_session =
          Repo.one(player_query)
          |> UserSession.from_player
        {user_session, "Welcome back #{user_session.username}!"}
    end

    conn
    |> put_session(:current_user, player)
    |> put_flash(:info, message)
    |> redirect(to: "/")
  end


  def logout(conn, _) do
    conn
    |> clear_session
    |> redirect(to: "/")
  end


  def set_user_session(conn, service_id, username) do
    q = from(p in Player,
      join: a in PlayerExternalAccount,
      on: p.id == a.player_id,
      where: a.service_id == ^service_id and a.username == ^username)

      {player, message} = case Repo.exists?(q) do
        false ->
          {:ok, player} =
            %Player{}
            |> Player.change_new(%{name: username, service_id: service_id})
            |> Repo.insert
          %PlayerExternalAccount{}
          |> PlayerExternalAccount.change_new(%{player_id: player.id, service_id: service_id, username: username})
          |> Repo.insert
          {UserSession.from_player(player), "Hello #{player.name}! Looks like your first time connection. Don't hesitate to edit your info here!"}
        true ->
          user_session =
            Repo.one(q)
            |> UserSession.from_player
          {user_session, "Welcome back #{user_session.username}!"}
      end

      conn
      |> put_session(:current_user, player)
      |> put_flash(:info, message)
      |> redirect(to: "/")
  end

end
