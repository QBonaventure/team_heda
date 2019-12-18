defmodule TeamHeda.Repo.Migrations.CreateEventsTypesTable do
  use Ecto.Migration

  def up do
    create table(:events_types) do
      add :name, :string
    end

    create index(:events_types, [:name])
    flush()
    add_event_types_data()
  end

  def down do
    drop table("events_types")
  end

  def add_event_types_data do
    TeamHeda.Repo.insert_all(
      TeamHeda.EventType,
      [
        %{name: "Tournament"},
        %{name: "League"},
        %{name: "Scrim"},
        %{name: "Misc."}
      ]
    )
  end

end
