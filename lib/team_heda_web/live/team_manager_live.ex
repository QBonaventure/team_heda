defmodule TeamHedaWeb.TeamManagerLive do
  use Phoenix.LiveView
  alias __MODULE__
  alias TeamHedaWeb.TeamView
  alias TeamHeda.{Repo,Team,Game}

  def render(assigns) do
    TeamView.render("manager.html", assigns)
  end

  def handle_params(params, _uri, socket) do
    team =
      Repo.get(Team, params["id"])
      |> Repo.preload([:players, :manager, :games, :lineups])
    games = Game.get_all()

    blah = [1, 2]
    socket =
      socket
      |> assign(:team, team)
      |> assign(:team_players, team.players)
      |> assign(:team_manager, team.manager)
      |> assign(:team_games, team.games)
      |> assign(:team_lineups, team.lineups)
      |> assign(:games, games)
      |> assign(:games_suggestions, [])
      |> assign(:added_game, nil)

    {:noreply, socket}
  end


  def mount(session, socket) do
    IO.inspect session
    {:ok, socket |> assign(messages: []), temporary_assigns: [team_players: [], team_games: []]}
  end


  def get_game_by_id(games, id) do
    Enum.find(games, fn(game) ->
      {id, _} = Integer.parse(id)
      game.id == id
    end)
  end


  ### Event handling

  def handle_event("search-game", params, socket) do
    needle = params["value"]
    games = socket.assigns.games

    matches = Enum.filter(games, fn(game) ->
      name = game.name
      String.match?(name, ~r/#{needle}/)
    end)

    {:noreply, assign(socket, games_suggestions: matches)}
  end


  def handle_event("suggested-game-selected", %{"gameid" => id}, socket) do
    game = get_game_by_id(socket.assigns.games, id)

    socket =
      socket
      |> assign(games_suggestions: [])
      |> assign(added_game: game)

    {:noreply, socket}
  end


  def handle_event("validate-game-selected", %{"gameid" => id}, socket) do
    game = get_game_by_id(socket.assigns.games, id)

    Team.add_game_changeset(socket.assigns.team, game)
    |> Repo.update

    socket =
      socket
      |> assign(added_game: nil)
      |> assign(team_games: [game])
    {:noreply, socket}
  end


  def handle_event("cancel-game-selected", _, socket) do
    {:noreply, assign(socket, added_game: nil)}
  end


end
