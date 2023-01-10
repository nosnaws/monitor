defmodule MonitorWeb.PageView do
  use MonitorWeb, :view

  def get_notes() do
    Monitor.Note.get_all()
  end
end
