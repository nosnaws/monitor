defmodule Monitor.Note do
  import Ecto.Query
  use Ecto.Schema

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Monitor.PubSub, @topic)
  end

  def broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Monitor.PubSub, @topic, {__MODULE__, event, result})
  end

  schema "notes" do
    field :message, :string
    field :created_at, :utc_datetime
  end

  def changeset(note, params \\ %{}) do
    note
    |> Ecto.Changeset.cast(params, [:message, :created_at])
    |> Ecto.Changeset.validate_required([:message, :created_at])
  end

  def create(message) do
    created_at = DateTime.utc_now()
    params = %{:message => message, :created_at => created_at}

    case(
      %Monitor.Note{}
      |> Monitor.Note.changeset(params)
      |> Monitor.Repo.insert()
    ) do
      {:ok, _note} = result ->
        broadcast_change(result, [:note, :created])

      {:error, changeset} ->
        Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)
        |> IO.inspect()
    end
  end

  def get_all() do
    Monitor.Repo.all(
      from(note in Monitor.Note,
        order_by: [desc: note.created_at]
      )
    )
  end

  def get_time_range(start_time, end_time) do
    Monitor.Repo.all(
      from(note in Monitor.Note,
        where: note.created_at >= ^start_time,
        where: note.created_at < ^end_time,
        order_by: [desc: note.created_at]
      )
    )
  end

  def get_after(start_time) do
    get_time_range(start_time, DateTime.utc_now())
  end

  def get_before(datetime) do
    get_time_range(DateTime.from_unix!(0), datetime)
  end
end

defimpl Jason.Encoder, for: Monitor.Note do
  def encode(value, opts) do
    Jason.Encode.map(Map.take(value, [:message, :created_at]), opts)
  end
end
