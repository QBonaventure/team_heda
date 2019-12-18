defmodule TeamHeda.EventType do
  use Ecto.Schema
  import Ecto.{Query,Changeset}

  schema "events_types" do
    field :name, :string
    field :is_online, :boolean
  end
end
