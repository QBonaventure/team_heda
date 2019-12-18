defmodule TeamHeda.Repo.Migrations.CreatePlayersGames do
  use Ecto.Migration

  def change do
    create table(:players_games, primary_key: false) do
      add(:player_id, references(:players), primary_key: true)
      add(:game_id, references(:games), primary_key: true)
    end

    create(index(:players_games, [:player_id]))
    create(index(:players_games, [:game_id]))

    create(
      unique_index(:players_games, [:player_id, :game_id], name: :uk_players_games)
    )

  end
end
