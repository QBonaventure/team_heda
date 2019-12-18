defmodule TeamHeda.Event do
  use Ecto.Schema
  import Ecto.{Query,Changeset}
  alias StreamHeda.EventType

  schema "events" do
    field :name, :string
    field :link, :string
    belongs_to :type, EventType
    timestamps
  end

end
