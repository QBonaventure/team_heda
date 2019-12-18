defmodule TeamHedaWeb.PlayerProfileLive do
  use Phoenix.LiveView
  alias TeamHedaWeb.PlayerProfileView
  alias TeamHeda.{Team,Player,Repo}
  alias TeamHedaWeb.Live.Component.TeamFormComponent

  def render(assigns) do
    PlayerProfileView.render("manager.html", assigns)
  end


  def mount(session, socket) do
    player =
      Repo.get(Player, session.current_user.id)
      |> Repo.preload([:managed_teams, :teams, :games, external_accounts: [:service]])

    socket =
      socket
      |> assign(player: player)
      |> assign(player_changeset: Player.update_my_infos_changeset(player))
      |> assign(form: nil)
      |> assign(managed_teams: player.managed_teams)
      |> assign(teams: player.teams)
      |> assign(external_accounts: player.external_accounts)
      IO.inspect player.external_accounts

    {:ok, socket, temporary_assigns: [managed_teams: [], teams: []]}
  end


  def handle_info({"cancel-form"}, socket) do
    {:noreply, assign(socket, :form, nil)}
  end


  def handle_event("open-create-team-form", _params, socket) do
    socket =
      socket
      |> assign(:form, team_form(socket))

    {:noreply, socket}
  end


  def handle_event("update-my-info", params, socket) do
    player = socket.assigns.player
    changeset =
      player
      |> Player.update_my_infos_changeset(params["player"])

    case Repo.update changeset do
      {:ok, player} ->
        socket =
          socket
          |> assign(player: player)
          |> assign(player_changeset: changeset)
        {:noreply, socket}
      {:error, changeset} ->
        {:noreply, assign(socket, player_changeset: changeset)}
    end
  end

  def handle_event("validate-my-infos", params, socket) do
    changeset =
      socket.assigns.player
      |> Player.update_my_infos_changeset(%{name: params["value"]})

    case Ecto.Changeset.apply_action(changeset, :update) do
      {:error , changeset} ->
          {:noreply, assign(socket, player_changeset: changeset)}
      {:ok, _} ->
          {:noreply, assign(socket, player_changeset: changeset)}
    end
  end


  def handle_info({:created_team, new_team}, socket) do
    socket =
      socket
      |> assign(:managed_teams, new_team)
      |> assign(:teams, new_team)
      |> assign(:form, nil)
    {:noreply, socket}
  end


  def team_form(socket) do
    changeset = Team.create_team_changeset(%Team{}, %{}, %Player{})
    live_component(socket, TeamFormComponent, id: "team-form", changeset: changeset, player: socket.assigns.player)
  end

end
