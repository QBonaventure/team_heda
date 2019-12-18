defmodule TeamHeda.Repo.Migrations.CreatePlayersExternalAccountsTable do
  use Ecto.Migration

  def change do
    create table(:players_external_accounts, primary_key: false) do
      add :player_id, references(:players), primary_key: true
      add :service_id, references(:external_services), primary_key: true
      add :username, :string
      add :ext_user_id, :string
    end

    create index(:players_external_accounts, [:player_id])
    create index(:players_external_accounts, [:service_id])
  end
end
