defmodule TeamHeda.UserSession do
  import Ecto.Changeset
  alias TeamHeda.{UserSession,Player}

  defstruct [:username, :id]

  def from_player(%Player{name: username, id: id}) do
    %UserSession{username: username, id: id}
  end

end
