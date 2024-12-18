# defmodule MyCalendar.Repo do
#   use Ecto.Repo,
#     otp_app: :my_calendar,
#     adapter: Ecto.Adapters.Postgres
# end

defmodule MyCalendar.Repo do
  use Ecto.Repo,
    otp_app: :my_calendar,
    adapter: Ecto.Adapters.SQLite3
end
