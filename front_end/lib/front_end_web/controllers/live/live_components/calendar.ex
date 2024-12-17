defmodule FrontEndWeb.CalendarComponent do
  use Phoenix.LiveComponent
  alias FrontEnd.Errands

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(
       calendar: make_calendar(assigns.initial_date),
       weeks: weeks_in_month(assigns.initial_date),
       current_month: parse_month(assigns.initial_date.month),
       selected: assigns.initial_date.day |> to_string,
       errands: Errands.get_errands(assigns.initial_date)
     )}
  end

  @months ~w"January February March April May June July August September October November December"
  def render(assigns) do
    ~H"""
    <div class="bg-white dark:bg-slate-800 rounded-lg shadow-lg p-4 max-w-md mx-auto">
      <div class="flex justify-between items-center mb-4">
        <div class="text-lg font-semibold text-gray-800 dark:text-white">
          <span>{@current_month} {@initial_date.year}</span>
        </div>
        <div class="flex flex-row dark:text-white">
          <Heroicons.icon
            name="chevron-left"
            type="outline"
            class="size-5 hover:bg-gray-300 dark:hover:bg-gray-500 rounded-full"
            phx-click="prev_month"
            phx-target={@myself}
          />
          <Heroicons.icon
            name="chevron-right"
            type="outline"
            class="size-5 hover:bg-gray-300 dark:hover:bg-gray-500 rounded-full"
            phx-click="next_month"
            phx-target={@myself}
          />
        </div>
      </div>
      <div class="">
        <table class="table-auto w-full ">
          <tr>
            <th
              :for={week_day <- ~w"Mo Tu We Th Fr Sa Su"}
              class="px-2 py-2 text-sm text-center text-gray-600 dark:text-white"
            >
              {week_day}
            </th>
          </tr>
          <tr :for={week <- 0..(@weeks - 1)}>
            <td
              :for={day <- @calendar |> Enum.at(week)}
              class={"text-center py-2 " <> (if day == @selected, do: "bg-red-500 dark:bg-green-500 text-white rounded-full", else: "text-slate-400 hover:bg-gray-300 dark:hover:bg-gray-600")}
              phx-click="select"
              phx-target={@myself}
              phx-value-day={day}
            >
              {day}
            </td>
          </tr>
        </table>
      </div>
      <div div class="mt-4 dark:text-white">
        <ul class="space-y-2">
          <li :for={errand <- @errands} class="flex flex-col">
            <span class="text-sm text-slate-500">
              {Calendar.strftime(errand.to_do_at, "%I:%M %p")}
            </span>
            <span>{errand.description}</span>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("prev_month", _, socket) do
    new_date = socket.assigns.initial_date |> prev_month

    {:noreply,
     socket
     |> assign(
       initial_date: new_date,
       calendar: make_calendar(new_date),
       weeks: weeks_in_month(new_date),
       current_month: parse_month(new_date.month),
       errands: Errands.get_errands(new_date),
       selected: "1"
     )}
  end

  def handle_event("next_month", _, socket) do
    new_date = socket.assigns.initial_date |> next_month

    {:noreply,
     socket
     |> assign(
       initial_date: new_date,
       calendar: make_calendar(new_date),
       weeks: weeks_in_month(new_date),
       current_month: parse_month(new_date.month),
       errands: Errands.get_errands(new_date),
       selected: "1"
     )}
  end

  def handle_event("select", %{"day" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("select", %{"day" => day}, socket) do
    new_date = %Date{socket.assigns.initial_date | day: String.to_integer(day)}

    {:noreply,
     socket
     |> assign(
       selected: day,
       initial_date: new_date,
       errands: Errands.get_errands(new_date)
     )}
  end

  defp make_calendar(date) do
    reference_date = Date.new!(date.year, date.month, 1)
    prepend = Date.day_of_week(reference_date) - 1

    1..(reference_date |> Date.days_in_month())
    |> Enum.map(&to_string/1)
    |> then(fn list -> apply(&Kernel.++/2, [List.duplicate("", prepend), list]) end)
    |> Enum.chunk_every(7)
  end

  def weeks_in_month(date) do
    first_day = Date.new!(date.year, date.month, 1)
    days_in_month = Date.days_in_month(first_day)
    first_day_of_week = Date.day_of_week(first_day)
    total_days = days_in_month + (first_day_of_week - 1)
    div(total_days, 7) + if rem(total_days, 7) > 0, do: 1, else: 0
  end

  defp parse_month(month), do: @months |> Enum.at(month - 1)

  defp prev_month(date) do
    previous_month = Date.add(date, -date.day)
    Date.beginning_of_month(previous_month)
  end

  defp next_month(date) do
    next_month = date |> Date.add(Date.days_in_month(date) - date.day + 1)
    Date.beginning_of_month(next_month)
  end
end
