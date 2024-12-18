defmodule MySuperCalendarWeb.CalendarPage do
  use MySuperCalendarWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(days_in_month: Enum.to_list(1..31))
     |> assign(week_days: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"])}
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

    <div class="w-[563px] h-[560px] rounded-xl fixed top-[50%] left-[50%] transform -translate-x-[50%] -translate-y-[50%] p-[72px] bg-white dark:bg-gray-900">
      <div class="flex justify-between items-center mb-[52px]">
        <p class="font-bold text-black dark:text-white">December 2024</p>
        <div class="flex gap-[5px]">
          <button type="button" class="p-[5px] text-black dark:text-white"><%= "<" %></button>
          <button type="button" class="p-[5px] text-black dark:text-white"><%= ">" %></button>
        </div>
      </div>
      <ul class="flex gap-[3px]">
        <%= for week_day <- @week_days do %>
          <li class="flex justify-center items-center w-[55px] h-[55px] text-lg text-black dark:text-white">
            <%= week_day %>
          </li>
        <% end %>
      </ul>
      <ul class="flex flex-wrap gap-[3px]">
        <%= for {month_day, index} <- Enum.with_index(@days_in_month) do %>
          <%= if index == 0 do %>
            <li class="flex justify-center items-center ml-[180px] w-[55px] h-[55px] text-gray-500 dark:text-gray-400">
              <%= month_day %>
            </li>
          <% else %>
            <%= if month_day == 18 do %>
              <li class="flex justify-center items-center w-[55px] h-[55px] rounded-full bg-[#e83b27] dark:bg-lime-600 text-white">
                <%= month_day %>
              </li>
            <% else %>
              <li class="flex justify-center items-center w-[55px] h-[55px] text-gray-500 dark:text-gray-400">
                <%= month_day %>
              </li>
            <% end %>
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
