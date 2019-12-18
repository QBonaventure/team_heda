defmodule TeamHeda.Repo do
  use Ecto.Repo,
    otp_app: :team_heda,
    adapter: Ecto.Adapters.Postgres
end
