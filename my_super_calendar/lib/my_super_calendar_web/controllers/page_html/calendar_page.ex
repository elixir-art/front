defmodule MySuperCalendarWeb.CalendarPage do
  use MySuperCalendarWeb, :live_view

  def mount(_params, _session, socket) do
    first_day_of_month = :calendar.day_of_the_week(2024, 12, 1)

    {:ok,
     socket
     |> assign(days_in_month: Enum.to_list(1..31))
     |> assign(week_days: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"])
     |> assign(first_day_of_month: first_day_of_month)}
  end

  def render(assigns) do
    ~H"""
    <div id="theme_toggle_id" phx-hook="ThemeToggle">
      <button
        class="btn mb-5 bg-gradient-to-r from-gray-800 via-gray-900 to-blue-900 hover:from-gray-700 hover:via-gray-800 hover:to-blue-800 text-white font-bold py-3 px-6 rounded-full shadow-lg transition-transform transform hover:scale-105 focus:outline-none focus:ring-4 focus:ring-blue-400 focus:ring-opacity-50"
        type="button"
        phx-click="change_theme"
      >
        Change Theme
      </button>
    </div>

    <div class="w-[560px] h-[560px] rounded-xl fixed top-[50%] left-[50%] transform -translate-x-[50%] -translate-y-[50%] p-[72px] bg-white dark:bg-gray-900">
      <div class="flex justify-between items-center mb-[52px] mb-4">
        <p class="text-xl font-bold text-black dark:text-white">December 2024</p>
        <div class="flex gap-[3px]">
          <button type="button" class="text-xl p-[8px] text-black dark:text-white"><%= "<" %></button>
          <button type="button" class="text-xl p-[8px] text-black dark:text-white"><%= ">" %></button>
        </div>
      </div>
      <ul class="flex gap-[3px]">
        <%= for week_day <- @week_days do %>
          <li class="text-xl flex justify-center items-center w-[56px] h-[56px] text-lg text-black dark:text-white">
            <%= week_day %>
          </li>
        <% end %>
      </ul>

      <ul class="flex flex-wrap gap-[3px]">
        <%= for _ <- 1..(@first_day_of_month - 1) do %>
          <li class="text-xl flex justify-center items-center w-[56px] h-[56px] text-lg text-black dark:text-white">
          </li>
        <% end %>

        <%= for {month_day, _index} <- Enum.with_index(@days_in_month) do %>
          <%= if month_day == 18 do %>
            <li class="text-xl flex justify-center items-center w-[56px] h-[56px] rounded-full bg-[#e83b27] dark:bg-lime-600 text-white">
              <%= month_day %>
            </li>
          <% else %>
            <li class="text-xl flex justify-center items-center w-[56px] h-[56px] text-lg text-black dark:text-white">
              <%= month_day %>
            </li>
          <% end %>
        <% end %>
      </ul>
    </div>
    """
  end

  def handle_event("change_theme", _, socket) do
    {:noreply, push_event(socket, "toggle_theme", %{})}
  end
end
