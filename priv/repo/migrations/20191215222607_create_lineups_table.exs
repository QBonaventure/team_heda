defmodule TeamHeda.Repo.Migrations.CreateLineupsTable do
  use Ecto.Migration

  def change do
    create table(:lineups) do
      add :team_id, references(:teams, on_delete: :delete_all)
      add :game_id, references(:games, on_delete: :delete_all)
      add :event_id, references(:events, on_delete: :delete_all)
      add :name, :string
      add :shortname, :string
      timestamps()
    end

    create index(:lineups, [:name])
    create index(:lineups, [:shortname])
  end

end
