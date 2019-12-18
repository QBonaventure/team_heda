defmodule TeamHeda.Repo.Migrations.CreateEventsTable do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :type_id, references(:events_types)
      add :name, :string
      add :link, :string
      timestamps()
    end

    create index(:events, [:name])

    create unique_index(:events, [:name], name: :uk_events_names)
  end

end
