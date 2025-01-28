defmodule MyCalendarWeb.Form.Contacts do
  use Phoenix.LiveComponent
  alias MyCalendarWeb.IconComponent

  def update(assigns, socket) do
    contacts = [
      %{
        name: "name",
        placeholder: "John Carter",
        type: "text",
        label: "Name",
        icon: %{
          name: "name",
          stroke: "#A0A3BD",
          fill: "none",
          width: 23,
          height: 29,
          viewBox: "0 0 23 29",
          stroke_width: 1.6
        }
      },
      %{
        name: "email",
        placeholder: "Email address",
        type: "email",
        label: "Email",
        icon: %{
          name: "email",
          stroke: "#A0A3BD",
          fill: "none",
          width: 25,
          height: 19,
          viewBox: "0 0 25 19",
          stroke_width: 1.6
        }
      },
      %{
        name: "phone",
        placeholder: "(123) 456 - 7890",
        type: "text",
        label: "Phone Number",
        icon: %{
          name: "mobile",
          stroke: "#A0A3BD",
          fill: "none",
          width: 17,
          height: 29,
          viewBox: "0 0 17 29",
          stroke_width: 1.6
        }
      },
      %{
        name: "company",
        placeholder: "Company name",
        type: "text",
        label: "Company",
        icon: %{
          name: "company",
          stroke: "#A0A3BD",
          fill: "none",
          width: 17,
          height: 32,
          viewBox: "0 0 17 32",
          stroke_width: 1.6
        }
      }
    ]

    socket =
      socket
      |> assign(:contacts, contacts)
      |> assign(assigns)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class={"#{assigns[:class]}"}>
      <h2 class="text-xl font-bold mb-4">Contact details</h2>
      <p class="text-gray-500 mb-6">Lorem  puisum</p>
      <form phx-change="update_form">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <%= for contact <- @contacts do %>
            <div>
              <label for={contact.name} class="block text-sm font-medium text-gray-700 mb-4">
                <%= contact.label %>
              </label>
              <div class="relative">
                <input
                  type={contact.type}
                  name={"form_data[#{contact.name}]"}
                  id={contact.name}
                  class={"#{if assigns.errors[contact.name], do: "border-2 border-rose-600", else: "border-gray-300" } w-72 h-16 px-4 py-2 border rounded-input focus:ring-indigo-500 focus:border-indigo-500"}
                  placeholder={contact.placeholder}
                />
                <div class="absolute inset-y-0 right-12 flex items-center text-gray-400">
                  <IconComponent.render
                    name={contact.icon.name}
                    stroke={contact.icon.stroke}
                    fill={contact.icon.fill}
                    width={contact.icon.width}
                    height={contact.icon.height}
                    viewBox={contact.icon.viewBox}
                    strokeWidth={contact.icon.stroke_width}
                  />
                </div>
              </div>
              <%= if @errors[contact.name] do %>
                <p class="text-red-500 text-sm mt-2"><%= @errors[contact.name] %></p>
              <% end %>
            </div>
          <% end %>
        </div>
      </form>
    </div>
    """
  end
end
