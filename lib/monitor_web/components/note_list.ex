defmodule NoteListComponent do
  use Phoenix.Component

  def create(assigns) do
    ~H"""
      <div class="note-list">
        <%= for note <- @notes do %>
          <NoteComponent.create note={note} />
        <% end %>
      </div>
    """
  end
end
