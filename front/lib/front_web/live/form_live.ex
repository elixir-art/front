# lib/front_web/live/form_live.ex
defmodule FrontWeb.FormLive do
  use FrontWeb, :live_view

  @max_steps 4
  @initial_form_data %{
    "name" => "",
    "email" => "",
    "phone" => "",
    "company" => "",
    "service" => nil,
    "budget" => nil
  }

  def mount(_params, _session, socket) do
    {:ok, assign(socket,
      current_step: 1,
      form_data: @initial_form_data
    )}
  end

  def handle_event("next_step", %{"form_data" => form_data}, socket) do
    current_step = socket.assigns.current_step

    if valid_step_data?(current_step, form_data) do
      new_step = min(current_step + 1, @max_steps)

      {:noreply,
       socket
       |> assign(:form_data, Map.merge(socket.assigns.form_data, form_data))
       |> assign(:current_step, new_step)}
    else
      {:noreply,
       socket
       |> put_flash(:error, "Please fill in all required fields")}
    end
  end

  def handle_event("prev_step", _params, socket) do
    new_step = max(socket.assigns.current_step - 1, 1)

    {:noreply, assign(socket, :current_step, new_step)}
  end

  def handle_event("submit", _params, socket) do
    if valid_submission?(socket.assigns.form_data) do
      form_data = socket.assigns.form_data

      {:noreply,
       socket
       |> put_flash(:info, "Your quote request has been submitted! We'll contact you within 24-48 hours.")
       |> redirect(to: ~p"/")
       |> assign(:form_data, form_data)}
    else
      {:noreply,
       socket
       |> put_flash(:error, "Please complete all steps before submitting")}
    end
  end

  def handle_event("validate", %{"form_data" => form_data}, socket) do
    {:noreply, assign(socket, :form_data, Map.merge(socket.assigns.form_data, form_data))}
  end

  defp valid_step_data?(step, form_data) do
    case step do
      1 ->
        !Enum.any?(["name", "email", "phone", "company"],
          &(is_nil(form_data[&1]) || String.trim(form_data[&1]) == ""))
      2 ->
        !is_nil(form_data["service"])
      3 ->
        !is_nil(form_data["budget"])
      _ ->
        true
    end
  end

  defp valid_submission?(form_data) do
    required_fields = ["name", "email", "phone", "company", "service", "budget"]
    Enum.all?(required_fields, &(Map.has_key?(form_data, &1) &&
      !is_nil(form_data[&1]) &&
      String.trim(form_data[&1]) != ""))
  end
end
