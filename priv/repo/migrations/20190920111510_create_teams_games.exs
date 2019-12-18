defmodule TeamHeda.Repo.Migrations.CreateTeamsGames do
  use Ecto.Migration

  def change do
    create table(:teams_games, primary_key: false) do
      add :team_id, references(:teams, on_delete: :delete_all), primary_key: true
      add :game_id, references(:games, on_delete: :delete_all), primary_key: true
    end

    create index(:teams_games, [:team_id])
    create index(:teams_games, [:game_id])
  end
end
