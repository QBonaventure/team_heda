defmodule TeamHeda.Repo.Migrations.CreateTeamsPlayers do
  use Ecto.Migration

  def change do
    create table(:teams_players, primary_key: false) do
      add(:player_id, references(:teams, on_delete: :delete_all), primary_key: true)
      add(:team_id, references(:players, on_delete: :delete_all), primary_key: true)
      timestamps()
    end

    create(index(:teams_players, [:player_id]))
    create(index(:teams_players, [:team_id]))

    create(
      unique_index(:teams_players, [:player_id, :team_id], name: :uk_teams_players)
    )

  end
end
