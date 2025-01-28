defmodule MyCalendarWeb.Form.Service do
  use Phoenix.LiveComponent
  alias MyCalendarWeb.IconComponent

  def update(assigns, socket) do
    services = [
      %{
        name: "development",
        label: "Development",
        icon: %{name: "setting", width: 40, height: 42, viewBox: "0 0 40 42"}
      },
      %{
        name: "web_design",
        label: "Web Design",
        icon: %{name: "marketing", width: 36, height: 29, viewBox: "0 0 36 29"}
      },
      %{
        name: "marketing",
        label: "Marketing",
        icon: %{name: "web", width: 39, height: 33, viewBox: "0 0 39 33"}
      },
      %{
        name: "other",
        label: "Other",
        icon: %{
          name: "development",
          width: 38,
          height: 33,
          viewBox: "0 0 38 33",
          stroke_width: 1.6
        }
      }
    ]

    default_service = List.first(services).name

    socket =
      socket
      |> assign(:selected_service, Map.get(assigns, :selected_service, default_service))
      |> assign(:services, services)
      |> assign(assigns)

    {:ok, socket}
  end

  def handle_event("select_service", %{"service" => selected_service}, socket) do
    send(self(), {:update_parent_state, %{"service" => selected_service}})
    {:noreply, assign(socket, selected_service: selected_service)}
  end

  def render(assigns) do
    ~H"""
    <div class={" #{assigns[:class]}"}>
      <h2 class="text-xl font-bold mb-4">Our services</h2>

      <p class="text-gray-500 mb-6">Please select which service you are interested in.</p>
      <div class="grid grid-cols-2 gap-y-6 gap-x-7">
        <%= for service <- @services do %>
          <label phx-click="select_service" phx-value-service={service.name} phx-target={@myself}>
            <div class={"flex items-center p-6 gap-3 rounded-target border-2 #{if @selected_service == service.name, do: "border-active", else: "border-target"} shadow-card"}>
              <div class="flex justify-center items-center w-16 h-16 rounded-full bg-indigo-100 text-indigo-600">
                <IconComponent.render
                  name={service.icon.name}
                  width={service.icon.width}
                  height={service.icon.height}
                  viewBox={service.icon.viewBox}
                  strokeWidth={Map.get(service.icon, :stroke_width, nil)}
                />
              </div>
              <span class="mt-2 font-medium"><%= service.label %></span>
            </div>
          </label>
        <% end %>
      </div>
    </div>
    """
  end
end
