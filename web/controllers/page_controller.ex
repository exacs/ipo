defmodule Ipo.PageController do
  use Ipo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
