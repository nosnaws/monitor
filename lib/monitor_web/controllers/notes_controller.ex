defmodule MonitorWeb.NotesController do
  use MonitorWeb, :controller

  def index(conn, _params) do
    notes = Monitor.Note.get_all()
    render(conn, "index.json", notes: notes)
  end

  def create(conn, params) do
    Monitor.Note.create(params["message"])
    text(conn, "Note created successfully")
  end
end
