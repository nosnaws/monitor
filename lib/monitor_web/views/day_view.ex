defmodule MonitorWeb.DayView do
  use MonitorWeb, :view
  @day_seconds 60 * 60 * 24

  def get_notes(num_days) do
    Monitor.Note.get_after(DateTime.add(DateTime.utc_now(), -(@day_seconds * num_days)))
  end
end
