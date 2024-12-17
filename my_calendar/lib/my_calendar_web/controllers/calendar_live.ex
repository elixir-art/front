defmodule MyCalendarWeb.CalendarLive do
  use MyCalendarWeb, :live_view
  alias Timex

  def mount(_params, _session, socket) do
    today = Date.utc_today()
    months = get_months()

    socket =
      assign(socket,
        current_date: today,
        selected_date: today,
        days: generate_calendar(today),
        current_month: months[today.month],
        current_year: today.year,
        months: months
      )

    {:ok, socket}
  end

  def handle_event("prev_month", _params, socket) do
    new_date = Timex.shift(socket.assigns.current_date, months: -1)

    socket =
      assign(socket,
        current_date: new_date,
        days: generate_calendar(new_date),
        current_month: socket.assigns.months[new_date.month],
        current_year: new_date.year
      )

    {:noreply, socket}
  end

  def handle_event("next_month", _params, socket) do
    new_date = Timex.shift(socket.assigns.current_date, months: 1)

    socket =
      assign(socket,
        current_date: new_date,
        days: generate_calendar(new_date),
        current_month: socket.assigns.months[new_date.month],
        current_year: new_date.year
      )

    {:noreply, socket}
  end

  def handle_event("select_day", %{"day" => day}, socket) do
    selected_date =
      socket.assigns.current_date
      |> Timex.set(day: String.to_integer(day))

    socket =
      assign(socket,
        selected_date: selected_date,
        days: generate_calendar(socket.assigns.current_date)
      )

    {:noreply, socket}
  end

  defp generate_calendar(current_date) do
    {year, month, _} = Date.to_erl(current_date)
    start_date = Date.new!(year, month, 1)
    end_date = Date.end_of_month(start_date)
    days_in_month = Date.range(start_date, end_date)

    empty_days_before = get_empty_days_before(start_date)

    days =
      Enum.map(days_in_month, fn date ->
        %{
          date: date.day,
          current_month: date.month,
          current_year: date.year,
          selected_date: false
        }
      end)

    empty_days_after = get_empty_days_after(days, empty_days_before)

    (empty_days_before ++ days ++ empty_days_after) |> IO.inspect(label: "DAYS")
  end

  defp get_months() do
    %{
      1 => "January",
      2 => "February",
      3 => "March",
      4 => "April",
      5 => "May",
      6 => "June",
      7 => "July",
      8 => "August",
      9 => "September",
      10 => "October",
      11 => "November",
      12 => "December"
    }
  end

  defp get_empty_days_before(start_date) do
    if(Date.day_of_week(start_date) == 1) do
      []
    else
      IO.inspect(Date.day_of_week(start_date), label: "AAAA")

      Enum.map(1..(Date.day_of_week(start_date) - 1), fn _ ->
        %{date: nil, current_year: false, current_month: false, selected_date: false}
      end)
    end
  end

  defp get_empty_days_after(days, empty_days_before) do
    empty_days_after_quantity = 7 - rem(length(days) + length(empty_days_before), 7)

    if empty_days_after_quantity == 7 do
      []
    else
      Enum.map(1..(7 - rem(length(days) + length(empty_days_before), 7)), fn _ ->
        %{date: nil, current_year: false, current_month: false, selected_date: false}
      end)
    end
  end
end
