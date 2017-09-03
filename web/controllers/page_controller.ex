defmodule Bookavoy.PageController do
  use Bookavoy.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
