defmodule MonitorWeb.DayController do
  use MonitorWeb, :controller

  def index(conn, %{"num" => num_days}) do
    render(conn, "index.html", num_days: String.to_integer(num_days))
  end
end
