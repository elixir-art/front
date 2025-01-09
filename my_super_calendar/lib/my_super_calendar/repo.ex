defmodule MySuperCalendar.Repo do
  use Ecto.Repo,
    otp_app: :my_super_calendar,
    adapter: Ecto.Adapters.Postgres
end
