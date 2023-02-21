defmodule MonitorWeb.Live.Home do
  use MonitorWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="row">
      <article class="column">
        <div class="create-note">  
          <form action="#" phx-submit="create_note" name="createNote">
            <%= textarea :note, :content, id: "createNoteArea", placeholder: "Just write something..." %>
            <div>
              <%= submit "Create", id: "submitCreateNote", phx_disable_with: "Creating..." %>
            </div>
          </form>
        </div>
        <h1>Notes</h1>
        <NoteListComponent.create notes={@notes} />
      </article>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    Monitor.Note.Channel.subscribe()

    {:ok, fetch(socket)}
  end

  def handle_info({Monitor.Note, [:note | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("create_note", %{"note" => note}, socket) do
    Monitor.Note.create(note["content"])

    {:noreply, fetch(socket)}
  end

  def fetch(socket) do
    assign(socket, notes: Monitor.Note.get_all())
  end
end
