defmodule TeamHeda.Team do
  use Ecto.Schema
  import Ecto.Changeset

  alias TeamHeda.{Player,Game,Team,LineUp}
  alias TeamHeda.Relations.TeamPlayer

  schema "teams" do
    many_to_many :games, Game, join_through: "teams_games", on_replace: :delete
    many_to_many :players, Player, join_through: TeamPlayer, on_replace: :delete
    has_many :lineups, LineUp
    belongs_to :manager, Player, references: :id

    field :name, :string
    field :shortname, :string

    timestamps()
  end




  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :shortname])
    |> validate_required([:name, :shortname])
  end


  def create_team_changeset(team = %Team{}, params \\ %{}, %Player{} = player) do
    team
    |> cast(params, [:name, :shortname])
    |> put_assoc(:manager, player)
    |> put_assoc(:players, [player])
    |> validate_required([:name, :shortname])
    |> validate_length(:shortname, min: 1)
    |> validate_length(:shortname, max: 3)
    |> validate_length(:name, min: 3)
    |> foreign_key_constraint(:user_name, name: "teams_players_player_id_fkey", message: "Player is already a player.")
  end


  def add_game_changeset(team = %Team{id: _id, games: _games}, game = %Game{id: _}) do
    games = [game] ++ team.games
    team
    |> change
    |> put_assoc(:games, games)
  end

end
