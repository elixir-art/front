defmodule CalanderWeb.PageHtml.Calander do
  use CalanderWeb, :live_view

  def render(assigns) do
    ~H"""
    <button class="btn" type="button" phx-click="change_theme">Change theme</button>
    <div class={"#{@container_color} w-[563px] h-[560px] rounded-xl fixed top-[50%] left-[50%] transform -translate-x-[50%] -translate-y-[50%] p-[72px]"}>
      <div class="flex justify-between items-center mb-[52px]">
        <p class={"font-bold #{@current_month_color}"}>October 2020</p>
        <div class="flex gap-[5px]">
          <button type="button" class={"p-[5px] #{@button_text_color}"}><%= "<" %></button>
          <button type="button" class={"p-[5px] #{@button_text_color}"}><%= ">" %></button>
        </div>
      </div>
      <ul class="flex gap-[3px]">
        <%= for week_day <- @week_days do %>
          <li class={"flex justify-center items-center w-[57px] h-[57px] text-lg #{@color_week_days}"}>
            <%= week_day %>
          </li>
        <% end %>
      </ul>
      <ul class="flex flex-wrap gap-[3px]">
        <%= for month_day <- @days_in_month do %>
          <%= if month_day == 1 do %>
            <li class={"flex justify-center items-center ml-[180px] w-[57px] h-[57px] #{@color_months_days}"}>
              <%= month_day %>
            </li>
          <% else %>
            <%= if month_day == 8 do %>
              <li class={"flex justify-center items-center #{@selected_day_bg_color} w-[57px] h-[57px] rounded-full #{@selected_day_text_color}"}>
                <%= month_day %>
              </li>
            <% else %>
              <li class={"flex justify-center items-center w-[57px] h-[57px] #{@color_months_days}"}>
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
    days_in_month =
      1..31
      |> Enum.to_list()

    week_days = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]

    {:ok,
     socket
     |> assign(days_in_month: days_in_month)
     |> assign(week_days: week_days)
     |> assign(current_theme_is_light: true)
     |> assign(container_color: "bg-white")
     |> assign(current_month_color: "text-black")
     |> assign(button_text_color: "text-black")
     |> assign(color_week_days: "text-black")
     |> assign(color_months_days: "text-gray-500")
     |> assign(selected_day_bg_color: "bg-[tomato]")
     |> assign(selected_day_text_color: "text-white")}
  end

  def handle_event("change_theme", _, socket) do
    socket = change_theme(socket, socket.assigns.current_theme_is_light)
    {:noreply, socket}
  end

  defp change_theme(socket, true) do #dark theme
    socket
    |> assign(current_theme_is_light: false)
    |> assign(container_color: "bg-gray-900")
    |> assign(current_month_color: "text-white")
    |> assign(button_text_color: "text-white")
    |> assign(color_week_days: "text-white")
    |> assign(color_months_days: "text-gray-400")
    |> assign(selected_day_bg_color: "bg-lime-600")
    |> assign(selected_day_text_color: "text-white")
  end

  defp change_theme(socket, false) do #light theme
    socket
    |> assign(current_theme_is_light: true)
    |> assign(container_color: "bg-white")
    |> assign(current_month_color: "text-black")
    |> assign(button_text_color: "text-black")
    |> assign(color_week_days: "text-black")
    |> assign(color_months_days: "text-gray-600")
    |> assign(selected_day_bg_color: "bg-[tomato]")
    |> assign(selected_day_text_color: "text-white")
  end
end
