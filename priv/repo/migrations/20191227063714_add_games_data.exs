defmodule TeamHeda.Repo.Migrations.AddGamesData do
  use Ecto.Migration

  def change do
    TeamHeda.Repo.insert_all(
      TeamHeda.Game,
      [
        %{name: "Trackmania²: Stadium"},
        %{name: "Heroes of the Storm"},
        %{name: "League of Legends"},
        %{name: "Rocket League"}
      ]
    )

  end
end
