defmodule TeamHeda.Repo.Migrations.CreateExternalServicesTable do
  use Ecto.Migration

  def up do
    create table(:external_services) do
      add :name, :string
      add :url, :string
    end

    flush()

    add_external_services_data()
  end

  def down do
    drop table(:external_services)
  end

  def add_external_services_data do
    TeamHeda.Repo.insert_all(
      TeamHeda.ExternalService,
      [
        %{name: "Maniaplanet", url: "https://discordapp.com"},
        %{name: "BattleNet", url: "https://www.blizzard.com"},
        %{name: "Epic", url: "https://www.epicgames.com"},
        %{name: "Steam", url: "https://store.steampowered.com"},
        %{name: "Discord", url: "https://discordapp.com"}
      ]
    )
  end
end
