defmodule Monitor.Repo.Migrations.CreateMonitor do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :message, :string
      add :created_at, :utc_datetime
    end
  end
end
