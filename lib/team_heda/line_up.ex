defmodule TeamHeda.LineUp do
  use Ecto.Schema
  import Ecto.Changeset
  alias TeamHeda.{Team,Game,LineUpPlayer,Event}

  schema "lineups" do
    belongs_to :team, Team
    belongs_to :game, Game
    belongs_to :event, Event
    has_many :players, LineUpPlayer
    field :name, :string
    field :shortname, :string
  end

end
