defmodule TeamHeda.Game do
  use Ecto.Schema
  alias __MODULE__
  import Ecto.{Changeset,Query}
  alias TeamHeda.{Player,Team,Repo}

  schema "games" do
    many_to_many :teams, Team, join_through: "teams_games"
    many_to_many :players, Player, join_through: "teams_players"

    field :name, :string
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end


  def get_all do
    Repo.all(from g in Game)
  end


  def is?(%Game{} = testee) do true end
  def is?(_) do false end


end
