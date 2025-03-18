defmodule Nice.Repo do
  use Ecto.Repo,
    otp_app: :nice,
    adapter: Ecto.Adapters.Postgres
end
