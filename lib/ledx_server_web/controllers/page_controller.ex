defmodule LEDxServerWeb.PageController do
  use LEDxServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
