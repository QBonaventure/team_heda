defmodule TeamHeda.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
    end

    create index(:games, [:name])
  end
end
