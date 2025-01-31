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
         "service" => "development",
         "name" => "",
         "email" => "",
         "phone" => "",
         "company" => ""
       },
       errors: %{}
     )}
  end

  def handle_event("submit_form", _params, socket) do
    {:noreply,
     socket
     |> put_flash(:info, "Yours data:\n#{Jason.encode!(socket.assigns.form_data, pretty: true)}")}
  end

  def handle_event(
        "update_form",
        %{"_target" => ["form_data", "name"], "form_data" => %{"name" => name}} = _form_data,
        socket
      ) do
    errors = validate_name(socket.assigns.errors, name)

    {:noreply,
     assign(socket,
       form_data: Map.merge(socket.assigns.form_data, %{"name" => name}),
       errors: errors
     )}
  end

  def handle_event(
        "update_form",
        %{"_target" => ["form_data", "email"], "form_data" => %{"email" => email}} = _form_data,
        socket
      ) do
    errors = validate_email(socket.assigns.errors, email)

    {:noreply,
     assign(socket,
       form_data: Map.merge(socket.assigns.form_data, %{"email" => email}),
       errors: errors
     )}
  end

  def handle_event(
        "update_form",
        %{"_target" => ["form_data", "phone"], "form_data" => %{"phone" => phone}} = _form_data,
        socket
      ) do
    errors = validate_phone(socket.assigns.errors, phone)

    {:noreply,
     assign(socket,
       form_data: Map.merge(socket.assigns.form_data, %{"phone" => phone}),
       errors: errors
     )}
  end

  def handle_event(
        "update_form",
        %{"_target" => ["form_data", "company"], "form_data" => %{"company" => company}} =
          _form_data,
        socket
      ) do
    errors = validate_company(socket.assigns.errors, company)

    {:noreply,
     assign(socket,
       form_data: Map.merge(socket.assigns.form_data, %{"company" => company}),
       errors: errors
     )}
  end

  def handle_event(
        "next_step",
        _params,
        %{assigns: %{current_step: step, form_data: form_data}} = socket
      ) do
    case validate_step(step, form_data) do
      :ok ->
        {:noreply, assign(socket, current_step: socket.assigns.current_step + 1)}

      {:error, errors} ->
        {:noreply, assign(socket, errors: errors)}
    end
  end

  def handle_event("prev_step", _params, socket) do
    {:noreply, assign(socket, current_step: max(socket.assigns.current_step - 1, 1))}
  end

  def handle_info({:update_parent_state, value}, socket) do
    {:noreply, assign(socket, form_data: Map.merge(socket.assigns.form_data, value))}
  end

  defp validate_step(1, form_data) do
    errors =
      %{}
      |> validate_company(form_data["company"])
      |> validate_email(form_data["email"])
      |> validate_name(form_data["name"])
      |> validate_phone(form_data["phone"])

    if map_size(errors) == 0, do: :ok, else: {:error, errors}
  end

  defp validate_step(_, _) do
    :ok
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
          formData={@form_data}
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
          class={"blue-button #{if @current_step == 4, do: "hidden", else: ""}"}
          phx-click="next_step"
          disabled={@current_step == 4}
        >
          Next step
        </button>
      </div>
    </div>
    """
  end

  defp validate_name(errors, name) do
    if String.split(name) |> Enum.count() < 2 do
      Map.put(errors, :name, "Name must be at least two words.")
    else
      Map.delete(errors, :name)
    end
  end

  defp validate_email(errors, email) do
    if Regex.match?(~r/^[^\s@]+@[^\s@]+\.[^\s@]+$/, email) do
      Map.delete(errors, :email)
    else
      Map.put(errors, :email, "Invalid email format.")
    end
  end

  defp validate_phone(errors, phone) do
    if Regex.match?(~r/^\(\d{3}\) \d{3} - \d{4}$/, phone) do
      Map.delete(errors, :phone)
    else
      Map.put(errors, :phone, "Invalid phone number format. Use (123) 456 - 7890.")
    end
  end

  defp validate_company(errors, company) do
    if String.trim(company) == "" do
      Map.put(errors, :company, "Company name cannot be blank.")
    else
      Map.delete(errors, :company)
    end
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
