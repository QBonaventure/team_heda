defmodule TeamHeda.PlayerGame do
  use Ecto.Schema
  import Ecto.{Query,Changeset}
  alias StreamHeda.{Player, Game}

  @primary_key false
  schema "players_games" do
    belongs_to :player, Player, primary_key: true
    belongs_to :game, Game, primary_key: true
  end

end
