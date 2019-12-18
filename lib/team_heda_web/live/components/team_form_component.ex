defmodule TeamHedaWeb.Live.Component.TeamFormComponent do
  use Phoenix.LiveComponent
  alias TeamHedaWeb.Live.Component.TeamFormComponent
  alias TeamHedaWeb.TeamView
  alias TeamHeda.{Team,Player,Repo}
  alias TeamHeda.Relations.TeamPlayer


  def render(socket) do
    TeamView.render("team-form.html", socket)
  end

  def handle_event("cancel-form", _params, socket) do
    send self(), {"cancel-form"}
    {:noreply, socket}
  end

  def handle_event("validate-name", params, socket) do
    changeset =
      %Team{}
      |> Team.create_team_changeset(%{name: params["value"]}, socket.assigns.player)

    {:error, changeset} = Ecto.Changeset.apply_action(changeset, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end


  def handle_event("create-team", params, socket) do
    player = socket.assigns.player
    changeset =
      %Team{}
      |> Team.create_team_changeset(params["team"], player)

    case Repo.insert changeset do
      {:ok, team} ->
        send self(), {:created_team, [team]}
        {:noreply, socket}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def populate_changeset()


end
