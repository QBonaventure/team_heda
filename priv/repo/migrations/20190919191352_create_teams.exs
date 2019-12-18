defmodule TeamHeda.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :shortname, :string
      add :manager_id, references(:players)
      timestamps()
    end

    create index(:teams, [:name])
    create index(:teams, [:shortname])
    create unique_index(:teams, [:name], name: :uk_teams_names)
  end

end
