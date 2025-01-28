defmodule MyCalendarWeb.Form.Budget do
  use Phoenix.LiveComponent

  def update(assigns, socket) do
    budget_checkbox = [
      %{price: "5000-10000", label: "$5.000 - $10.000"},
      %{price: "10000-20000", label: "$10.000 - $20.000"},
      %{price: "20000-50000", label: "$20.000 - $50.000"},
      %{price: "50000+", label: "$50.000+"}
    ]

    default_budget = List.first(budget_checkbox).price

    socket =
      socket
      |> assign(:selected_budget, Map.get(assigns, :selected_budget, default_budget))
      |> assign(:budget_checkbox, budget_checkbox)
      |> assign(assigns)

    {:ok, socket}
  end

  def handle_event("update_state", %{"budget" => selected_budget}, socket) do
    send(self(), {:update_parent_state, %{"budget" => selected_budget}})
    {:noreply, assign(socket, selected_budget: selected_budget)}
  end

  def render(assigns) do
    ~H"""
    <div class={" #{assigns[:class]}"}>
      <h2 class="text-xl font-bold mb-4">What’s your project budget?</h2>

      <p class="text-gray-500 mb-6">Please select the project budget range you have in mind.</p>
      <div class="grid grid-cols-2 gap-y-6 gap-x-7">
        <%= for budget <- @budget_checkbox do %>
          <label phx-click="update_state" phx-value-budget={budget.price} phx-target={@myself}>
            <div class={"flex items-center gap-3 py-11 px-8 rounded-target border-2 #{if @selected_budget == budget.price, do: "border-active", else: "border-target"} shadow-card cursor-pointer"}>
              <input
                type="radio"
                name="budget"
                value={budget.price}
                checked={@selected_budget == budget.price}
              />
              <span class="font-medium"><%= budget.label %></span>
            </div>
          </label>
        <% end %>
      </div>
    </div>
    """
  end
end
