defmodule TeamHedaWeb.PageController do
  use TeamHedaWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
