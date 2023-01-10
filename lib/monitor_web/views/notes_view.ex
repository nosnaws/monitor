defmodule MonitorWeb.NotesView do
  use MonitorWeb, :view

  def render("index.json", %{notes: notes}) do
    %{data: render_many(notes, MonitorWeb.NotesView, "note.json")}
  end

  def render("show.json", %{notes: note}) do
    %{data: render_one(note, MonitorWeb.NotesView, "note.json")}
  end

  def render("note.json", %{notes: %Monitor.Note{} = note}) do
    %{message: note.message, created_at: note.created_at}
  end
end
