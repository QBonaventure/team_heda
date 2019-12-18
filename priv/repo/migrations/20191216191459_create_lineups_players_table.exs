defmodule TeamHeda.Repo.Migrations.CreateLineupsPlayers do
  use Ecto.Migration

  def change do
    create table(:lineups_players, primary_key: false) do
      add(:player_id, references(:teams), primary_key: true)
      add(:lineup_id, references(:lineups), primary_key: true)
      timestamps()
    end

    create(index(:lineups_players, [:player_id]))
    create(index(:lineups_players, [:lineup_id]))

    create(
      unique_index(:lineups_players, [:player_id, :lineup_id], name: :uk_lineups_players)
    )

  end
end
