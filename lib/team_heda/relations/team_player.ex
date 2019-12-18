defmodule TeamHeda.Relations.TeamPlayer do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__
  alias TeamHeda.{Player,Team}


  @primary_key false
  schema "teams_players" do
    belongs_to :player, Player, primary_key: true
    belongs_to :team, Team, primary_key: true
    timestamps()
  end

  def changeset(%Team{} = team, %Player{} = player) do
  %TeamPlayer{}
  |> cast(%{team_id: team.id, player_id: player.id}, [:team_id, :player_id])
  |> validate_required([:team_id, :player_id])
  |> foreign_key_constraint(:players, name: "teams_players_player_id_fkey", message: "Player does not exist.")
  |> foreign_key_constraint(:teams, name: "teams_players_team_id_fkey", message: "Team does not exist.")
  end

end
