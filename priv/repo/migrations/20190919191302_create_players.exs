defmodule TeamHeda.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      timestamps()
    end

    create index(:players, [:name])
  end

end
