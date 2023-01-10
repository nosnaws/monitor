defmodule Monitor.Repo do
  use Ecto.Repo,
    otp_app: :monitor,
    adapter: Ecto.Adapters.Postgres
end
