defmodule FrontAppWeb.Calendar do
  use FrontAppWeb, :live_view

  def mount(_params, _session, socket) do
    today = Date.utc_today()
    today.month

    {:ok,
     socket
     |> assign_current_date(today)
     |> assign(dark_mode: false)
     |> assign(selected_date: today)}
  end

  def handle_event("prev_month", _value, socket) do
    {:noreply, socket |> assign_current_date(-1)}
  end

  def handle_event("next_month", _value, socket) do
    {:noreply, socket |> assign_current_date(1)}
  end

  def handle_event("toggle_theme", _value, socket) do
    {:noreply, socket |> assign(dark_mode: !socket.assigns.dark_mode)}
  end

  def handle_event("select_day", %{"value" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("select_day", %{"value" => day}, socket) do
    {:noreply, socket |> assign_selected_date(day)}
  end

  defp assign_current_date(socket, step) when is_number(step) do
    new_date =
      socket.assigns.current_date
      |> Date.beginning_of_month()
      |> Date.shift(month: step)

    assign_current_date(socket, new_date)
  end

  defp assign_current_date(socket, date) do
    first_day_of_week =
      date
      |> Date.beginning_of_month()
      |> Date.day_of_week()

    socket
    |> assign(current_date: date)
    |> assign(current_month_name: Calendar.strftime(date, "%B"))
    |> assign(days_month: 1..Date.days_in_month(date))
    |> assign(empty_cells: 1..(first_day_of_week - 1))
  end

  defp assign_selected_date(socket, day) do
    current_date = socket.assigns.current_date
    {:ok, selected_date} =
      Date.new(current_date.year, current_date.month, String.to_integer(day))

    socket
    |> assign(
      selected_date: selected_date)
  end
end
