defmodule CalanderWeb.PageHtml.Calander do
  use CalanderWeb, :live_view

  def render(assigns) do
    ~H"""
    <div id="theme_toggle_id" phx-hook="ThemeToggle">
      <button class="btn mb-5" type="button" phx-click="change_theme">Change Theme</button>
    </div>
    <div class="w-[563px] h-[560px] rounded-xl fixed top-[50%] left-[50%] transform -translate-x-[50%] -translate-y-[50%] p-[72px] bg-white dark:bg-gray-900">
      <div class="flex justify-between items-center mb-[52px]">
        <p class="font-bold text-black dark:text-white">October 2020</p>
        <div class="flex gap-[5px]">
          <button type="button" class="p-[5px] text-black dark:text-white"><%= "<" %></button>
          <button type="button" class="p-[5px] text-black dark:text-white"><%= ">" %></button>
        </div>
      </div>
      <ul class="flex gap-[3px]">
        <%= for week_day <- @week_days do %>
          <li class="flex justify-center items-center w-[57px] h-[57px] text-lg text-black dark:text-white">
            <%= week_day %>
          </li>
        <% end %>
      </ul>
      <ul class="flex flex-wrap gap-[3px]">
        <%= for month_day <- @days_in_month do %>
          <%= if month_day == 1 do %>
            <li class="flex justify-center items-center ml-[180px] w-[57px] h-[57px] text-gray-500 dark:text-gray-400">
              <%= month_day %>
            </li>
          <% else %>
            <%= if month_day == 8 do %>
              <li class="flex justify-center items-center w-[57px] h-[57px] rounded-full bg-[tomato] dark:bg-lime-600 text-white">
                <%= month_day %>
              </li>
            <% else %>
              <li class="flex justify-center items-center w-[57px] h-[57px] text-gray-500 dark:text-gray-400">
                <%= month_day %>
              </li>
            <% end %>
          <% end %>
        <% end %>
      </ul>
    </div>
    """
  end
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(days_in_month: Enum.to_list(1..31))
     |> assign(week_days: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"])}
  end

  def handle_event("change_theme", _, socket) do
    {:noreply, push_event(socket, "toggle_theme", %{})}
  end
end
