defmodule MyCalendarWeb.CalendarLive do
  use MyCalendarWeb, :live_view

  @months ~w(January February March April May June July August September October November December)
  @weekdays ~w(Mo Tu We Th Fr Sa Su)

  def mount(_params, _session, socket) do
    today = Date.utc_today()

    {:ok,
     assign(socket,
       current_date: today,
       days_in_month: days_in_month(Date.utc_today()),
       first_day_of_month: first_day_of_month(Date.utc_today()),
       dark_mode: false,
       months: @months,
       weekdays: @weekdays,
       selected_day: today.day
     )}
  end

  def handle_event("select_day", %{"day" => day}, socket) do
    {:noreply, assign(socket, selected_day: String.to_integer(day))}
  end

  def handle_event("toggle_theme", _, socket) do
    {:noreply, assign(socket, dark_mode: !socket.assigns.dark_mode)}
  end

  def handle_event("next_month", _, socket) do
    new_date = Date.add(socket.assigns.current_date, 28)
    update_calendar(socket, new_date)
  end

  def handle_event("prev_month", _, socket) do
    new_date = Date.add(socket.assigns.current_date, -28)
    update_calendar(socket, new_date)
  end

  defp update_calendar(socket, new_date) do
    {:noreply,
     assign(socket,
       current_date: new_date,
       days_in_month: days_in_month(new_date),
       first_day_of_month: first_day_of_month(new_date)
     )}
  end

  defp days_in_month(date) do
    Date.end_of_month(date).day
  end

  defp first_day_of_month(date) do
    Date.beginning_of_month(date)
    |> Date.day_of_week()
  end

  def render(assigns) do
    ~H"""
    <div class={"min-h-screen flex items-center justify-center transition-all" <> if @dark_mode, do: "dark", else: ""}>
      <div class="p-6 max-w-md w-full shadow-md rounded-lg dark:bg-white dark:text-gray-800 bg-coldBlack text-white">
        <div class="flex justify-between items-center mb-4">
          <h2 class="text-lg font-semibold">
            <%= Enum.at(@months, @current_date.month - 1) %>
            <%= @current_date.year %>
          </h2>
          <div class="flex gap-4">
            <button phx-click="prev_month">&lt;</button>
            <button phx-click="next_month">&gt;</button>
          </div>
        </div>
        <div class="grid grid-cols-7 text-center font-semibold">
          <%= for day <- @weekdays do %>
            <div><%= day %></div>
          <% end %>
        </div>
        <div class="grid grid-cols-7 gap-3 text-center">
          <%= for _ <- 1..(@first_day_of_month - 1) do %>
            <div class="p-2 text-gray-400"></div>
          <% end %>
          <%= for day <- 1..@days_in_month do %>
            <div
              phx-click="select_day"
              phx-value-day={day}
              class={"flex justify-center items-center p-2 cursor-pointer w-9 h-9 dark:text-customGray " <> if @selected_day == day, do: "rounded-full dark:bg-red bg-green text-white dark:text-white", else: ""}
            >
              <%= day %>
            </div>
          <% end %>
        </div>
        <button
          id="theme-hook"
          phx-hook="ThemeHook"
          class="mt-4 px-4 py-2 bg-gray-200 bg-white text-black dark:bg-gray-800 dark:text-white rounded"
        >
          Toggle Day/Night
        </button>
      </div>
    </div>
    """
  end
end
