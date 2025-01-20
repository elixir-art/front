defmodule CalanderWeb.PageHtml.Form do
  use CalanderWeb, :live_view

  def render(assigns) do
    ~H"""
    <div id="hook_test" phx-hook="Form">
      <button phx-click="handle_step_animation">Test</button>
    </div>
    <form id="first-section-form" phx-submit="save">
      <div class="bg-red-500 py-[32px] px-[46px] border-2 border-gray-200 rounded-lg fixed top-[50%] left-[50%] transform -translate-x-[50%] -translate-y-[50%]">
        <div class="border-b-2 border-gray-200 mb-[40px]">
          <ul class="flex items-center justify-center space-x-4 mx-[25px] mb-[20px]">
            <%= for section <- @sections do %>
              <li class="flex items-center justify-center text-gray-500 w-[30px] h-[30px] bg-gray-200 rounded-full text-lg">
                <div><%= section %></div>
              </li>
              <%= if section < 4 do %>
                <span class="loader w-12 h-1 bg-gray-300 rounded overflow-hidden relative">
                  <span id={"step-#{section}"}></span>
                </span>
              <% end %>
            <% end %>
          </ul>
        </div>
        <div class="mb-[40px]">
          <h2 class="font-medium mb-[10px]">Contact details</h2>
          <p class="text-xs text-gray-300">Lorem ipsum dolor sit amet consectetur adipisc.</p>
        </div>
        <div class="flex flex-col gap-[20px]">
          <div class="flex basis1/2 gap-[20px]">
            <div class="flex flex-col">
              <label class="mb-[10px]" for="name">Name</label>
              <input type="text" id="name" name="name" class="form-input rounded-full p-[15px] shadow-md border-gray-300 border-2" placeholder="John Carter" />
            </div>
            <div class="flex flex-col">
              <label class="mb-[10px]" for="email">Email</label>
              <input type="email" id="email" name="email" class="form-input rounded-full p-[15px] shadow-md border-gray-300 border-2" placeholder="Email adress" />
            </div>
          </div>
          <div class="flex basis-1/2 gap-[20px]">
            <div class="flex flex-col">
              <label class="mb-[10px]" for="phone">Phone Number</label>
              <input type="tel" id="phone" name="phone" class="form-input rounded-full p-[15px] shadow-md border-gray-300 border-2" placeholder="(123) 456 - 7890" />
            </div>
            <div class="flex flex-col">
              <label class="mb-[10px]" for="company">Company</label>
              <input type="text" id="company" name="company" class="form-input rounded-full p-[15px] shadow-md border-gray-300 border-2" placeholder="Company name" />
            </div>
          </div>
        </div>
        <button type="submit" id="submit-btn">Submit</button>
      </div>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(show_animation: false)
     |> assign(current_step: 0)
     |> assign(sections: [1, 2, 3, 4])}
  end

  def handle_event("test", _, socket) do
    {:noreply, push_event(socket, "test", %{test_parameter: "Hello World"})}
  end

  def handle_event("handle_step_animation", _params, socket) do
    current_step = socket.assigns.current_step + 1

    {:noreply,
     push_event(
       socket |> assign(current_step: current_step),
       "handle_step_animation",
       %{id: "step-#{current_step}"}
     )}
  end

  def handle_event("receive_param", params, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end
end
