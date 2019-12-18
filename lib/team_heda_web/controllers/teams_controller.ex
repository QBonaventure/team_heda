defmodule TeamHedaWeb.TeamsController do
  use TeamHedaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end


  def team_index(conn, %{"team_name" => teamName}) do
    render(conn, "team-index.html", teamName: teamName)
  end

end
