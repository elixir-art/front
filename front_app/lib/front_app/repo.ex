defmodule FrontApp.Repo do
  use Ecto.Repo,
    otp_app: :front_app,
    adapter: Ecto.Adapters.Postgres
end
