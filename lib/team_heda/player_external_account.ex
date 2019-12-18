defmodule TeamHeda.PlayerExternalAccount do
  use Ecto.Schema
  import Ecto.Changeset
  alias TeamHeda.{Player,ExternalService,PlayerExternalAccount}


  @primary_key false
  schema "players_external_accounts" do
    field :username, :string
    field :in_service_user_id, :string
    belongs_to :player, Player, primary_key: true
    belongs_to :service, ExternalService, primary_key: true
  end

  def change_new(%PlayerExternalAccount{player_id: nil} = new_account, data) do
    new_account
    |> cast(data, [:service_id, :username, :player_id, :ext_user_id])
    |> validate_required([:service_id, :player_id, :username, :ext_user_id])
  end

end
