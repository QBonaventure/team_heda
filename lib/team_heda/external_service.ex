defmodule TeamHeda.ExternalService do
  use Ecto.Schema
  import Ecto.{Changeset,Query}
  alias TeamHeda.Player

    schema "external_services" do
      has_many :players, Player
      field :name, :string
      field :url, :string
    end

end
