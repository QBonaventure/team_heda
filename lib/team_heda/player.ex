defmodule TeamHeda.Player do
  use Ecto.Schema
  import Ecto.Changeset

  alias TeamHeda.{Player,Team,Game,PlayerExternalAccount}
  alias TeamHeda.Relations.TeamPlayer

  schema "players" do
    many_to_many :games, Game, join_through: "players_games", on_replace: :delete
    many_to_many :teams, Team, join_through: TeamPlayer, on_replace: :delete
    has_many :managed_teams, Team, foreign_key: :manager_id
    has_many :external_accounts, PlayerExternalAccount

    field :name, :string

    timestamps()
  end

  def changeset(%Player{} = player, data) do
    player
    |> cast(data, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 2)
    |> validate_length(:name, max: 36)
  end


  def update_my_infos_changeset(%Player{} = player, data \\ %{}) do
    player
    |> cast(data, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 2)
    |> validate_length(:name, max: 36)
  end


  def registration_changeset(%Player{name: nil} = new_player, data) do
    new_player
    |> cast(data, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 2)
    |> validate_length(:name, max: 36)
  end

  def add_managed_team(player, created_team) do
    player
    |> cast(created_team, [])
    # |> cast_assoc(:managed_teams, with: &Team.create_team_changeset/2)
    |> put_assoc(:manager, [created_team])
  end

end
