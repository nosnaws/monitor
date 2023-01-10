defmodule NoteComponent do
  use Phoenix.Component

  @hour 60 * 60

  def create(assigns) do
    ~H"""
      <div class="note">
        <div>
          <%= Phoenix.HTML.Format.text_to_html(@note.message) %>
        </div>
        <span>
          <%= format_relative_date(@note.created_at) %>
        </span>
      </div>
    """
  end

  def format_relative_date(dt) do
    hours = DateTime.diff(DateTime.utc_now(), dt) / @hour

    cond do
      hours <= 1 -> "<1h"
      hours <= 24 -> "<1d"
      hours <= 48 -> ">1d"
      true -> Date.to_string(DateTime.to_date(dt))
    end
  end
end
