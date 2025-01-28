defmodule MyCalendarWeb.Form do
  use MyCalendarWeb, :live_view

  @number_of_components 4

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       current_step: 1,
       selected_service: nil,
       number_of_components: @number_of_components,
       form_data: %{
         "budget" => "5000-10000",
         "service" => "development"
       },
       errors: %{}
     )}
  end

  def handle_event("submit_form", _params, socket) do
    form_data = socket.assigns.form_data

    IO.inspect(form_data, label: "Form data submitted")

    {:noreply, socket}
  end

  def handle_event("update_form", params, socket) do
    %{"form_data" => %{"company" => company, "email" => email, "name" => name, "phone" => phone}} =
      params

    form_data = %{"company" => company, "email" => email, "name" => name, "phone" => phone}

    {:noreply, assign(socket, form_data: Map.merge(socket.assigns.form_data, form_data))}
  end

  def handle_info({:update_parent_state, value}, socket) do
    {:noreply, assign(socket, form_data: Map.merge(socket.assigns.form_data, value))}
  end

  def handle_event("next_step", _params, socket) do
    {:noreply, assign(socket, current_step: socket.assigns.current_step + 1)}
  end

  def handle_event("prev_step", _params, socket) do
    {:noreply, assign(socket, current_step: max(socket.assigns.current_step - 1, 1))}
  end

  defp validate_form(form_data) do
    Enum.reduce(form_data, %{}, fn
      {"name", value}, acc ->
        if String.trim(value) == "" do
          Map.put(acc, "name", "Name is required")
        else
          acc
        end

      {"email", value}, acc ->
        if String.trim(value) == "" do
          Map.put(acc, "email", "Email is required")
        else
          if Regex.match?(~r/^[\w._%+-]+@[\w.-]+\.[a-zA-Z]{2,}$/, value) do
            acc
          else
            Map.put(acc, "email", "Invalid email format")
          end
        end

      {"phone", value}, acc ->
        if String.trim(value) == "" do
          Map.put(acc, "phone", "Phone number is required")
        else
          acc
        end

      {"company", value}, acc ->
        if String.trim(value) == "" do
          Map.put(acc, "company", "Company name is required")
        else
          acc
        end

      _, acc ->
        acc
    end)
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto m-5">
      <div class="w-[698px] h-[606px] mx-auto px-14 pt-8 bg-white rounded-form shadow-lg">
        <div class="flex justify-start gap-4 items-center mb-8">
          <%= for step <- 1..@number_of_components do %>
            <div class="flex items-center gap-4">
              <div class={"w-8 h-8 flex items-center justify-center rounded-full font-bold #{if @current_step >= step, do: "bg-formPrimary-200 text-white", else: "bg-formSecondary-200 text-gray-600"}"}>
                <%= step %>
              </div>
              <%= if step < @number_of_components do %>
                <div class="relative h-1 w-24 bg-formSecondary-200 rounded-progress">
                  <span class={"absolute h-full bg-formPrimary-200 rounded-progress #{progress_class(@current_step, step)}"}>
                  </span>
                </div>
              <% end %>
            </div>
          <% end %>
        </div>
        <div class="w-full h-0.5 bg-card_bg-gray3"></div>
      
        <.live_component
          module={component_for(@current_step)}
          id={"step-#{@current_step}"}
          class="mt-14"
          errors={@errors}
        />
      </div>
      <div class={"w-[698px] mx-auto mt-8 flex #{if @current_step == 1, do: "justify-end", else: "justify-between"}"}>
        <button
          type="button"
          class={"w-48 h-16 bg-gray-200 text-gray-800 px-4 py-2 rounded-button #{if @current_step == 1, do: "hidden", else: ""}"}
          phx-click="prev_step"
          disabled={@current_step == 1}
        >
          Previous step
        </button>
        <button
          type="button"
          class={"w-40 h-16 bg-formPrimary-200 text-white px-4 py-2 rounded-button #{if @current_step == 4, do: "hidden", else: ""}"}
          phx-click="next_step"
          disabled={@current_step == 4}
        >
          Next step
        </button>
      </div>
    </div>
    """
  end

  defp progress_class(current_step, step) do
    cond do
      current_step > step -> "w-24"
      current_step == step -> "w-12"
      true -> "w-0"
    end
  end

  defp component_for(1), do: MyCalendarWeb.Form.Contacts
  defp component_for(2), do: MyCalendarWeb.Form.Service
  defp component_for(3), do: MyCalendarWeb.Form.Budget
  defp component_for(4), do: MyCalendarWeb.Form.Submit
end
