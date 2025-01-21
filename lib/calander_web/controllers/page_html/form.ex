defmodule CalanderWeb.PageHtml.Form do
  use CalanderWeb, :live_view

  def render(assigns) do
    ~H"""
    <form id="form" phx-hook="Form">
      <div class="py-[32px] px-[46px] shadow-2xl border border-gray-200 rounded-lg fixed top-[50%] left-[50%] transform -translate-x-[50%] -translate-y-[50%]">
        <div class="border-b-2 border-gray-200 mb-[40px]">
          <ul class="flex items-center justify-center space-x-4 mx-[25px] mb-[20px]">
            <%= for section <- @sections do %>
              <li
                id={"li-#{section}"}
                class="flex items-center justify-center text-gray-500 w-[30px] h-[30px] bg-gray-100 rounded-full text-lg"
              >
                <div><%= section %></div>
              </li>
              <%= if section < 4 do %>
                <span class="loader w-12 h-1 bg-gray-100 rounded overflow-hidden relative">
                  <span id={"step-#{section + 1}"}></span>
                </span>
              <% end %>
            <% end %>
          </ul>
        </div>
        <secton id="section-1" class="">
          <div class="mb-[40px]">
            <h2 class="font-medium text-xl mb-[10px]">Contact details</h2>
            <p class="text-base text-gray-300">Lorem ipsum dolor sit amet consectetur adipisc.</p>
          </div>
          <div class="flex flex-col gap-[20px]">
            <div class="flex basis1/2 gap-[20px]">
              <div class="flex flex-col">
                <label class="mb-[10px]" for="name">Name</label>
                <input
                  type="text"
                  id="name"
                  name="name"
                  class="form-input rounded-full py-[15px] shadow-md border-gray-300 border-2"
                  placeholder="John Carter"
                  required
                />
              </div>
              <div class="flex flex-col">
                <label class="mb-[10px]" for="email">Email</label>
                <input
                  type="email"
                  id="email"
                  name="email"
                  class="form-input rounded-full py-[15px] shadow-md border-gray-300 border-2"
                  placeholder="Email adress"
                  required
                />
              </div>
            </div>
            <div class="flex basis-1/2 gap-[20px]">
              <div class="flex flex-col">
                <label class="mb-[10px]" for="phone">Phone Number</label>
                <input
                  type="tel"
                  id="phone"
                  name="phone"
                  class="form-input rounded-full py-[15px] shadow-md border-gray-300 border-2"
                  placeholder="(123) 456 - 7890"
                  required
                />
              </div>
              <div class="flex flex-col">
                <label class="mb-[10px]" for="company">Company</label>
                <input
                  type="text"
                  id="company"
                  name="company"
                  class="form-input rounded-full py-[15px] shadow-md border-gray-300 border-2"
                  placeholder="Company name"
                  required
                />
              </div>
            </div>
          </div>
        </secton>
        <section id="section-2" class="hidden">
          <div class="mb-[40px]">
            <h2 class="font-medium text-xl mb-[10px]">Our services</h2>
            <p class="text-base text-gray-300">Please select which service you are interested in.</p>
          </div>
          <div class="flex flex-wrap gap-[15px]">
            <%= for second_section_blocks <- @second_section_blocks do %>
              <div
                id={"block-#{second_section_blocks.id}"}
                class="p-[20px] border border-gray-300 w-[48%] checkbox-container rounded-lg"
                phx-hook="CheckBoxOutline"
              >
                <div class="flex items-center gap-[15px]">
                  <input
                    type="checkbox"
                    name="selected_services"
                    id={"#{second_section_blocks.id}"}
                    value={"#{second_section_blocks.text}"}
                    class="checkbox-input hidden"
                  />
                  <div class="h-[60px] w-[60px] rounded-full bg-blue-300 flex items-center justify-center">
                    <svg class="w-[30px] h-[30px]">
                      <use href={~p"/images/form_sprite.svg##{second_section_blocks.icon}"}></use>
                    </svg>
                  </div>
                  <label for={"#{second_section_blocks.id}"}>
                    <%= second_section_blocks.text %>
                  </label>
                </div>
              </div>
            <% end %>
          </div>
        </section>
        <section id="section-3" class="hidden">
          <div class="mb-[40px]">
            <h2 class="font-medium mb-[10px] text-xl">What’s your project budget?</h2>
            <p class="text-base text-gray-300">
              Please select the project budget range you have in mind.
            </p>
          </div>
          <div class="flex flex-wrap gap-[10px]">
            <%= for third_section_block <- @third_section_blocks do %>
              <div
                id={"block-#{third_section_block.id}"}
                class="border border-gray-300 w-[48%] py-[30px] px-[10px] radio-container rounded-lg"
                phx-hook="RadioBoxOutline"
              >
                <div class="ml-[20px]">
                  <input
                    type="radio"
                    id={"#{third_section_block.id}"}
                    name="project-budget"
                    value={"#{third_section_block.text}"}
                  />
                  <label class="ml-[7px]" for={"#{third_section_block.id}"}>
                    <%= third_section_block.text %>
                  </label>
                </div>
              </div>
            <% end %>
          </div>
        </section>
        <section id="section-4" class="hidden">
          <div class="flex justify-center min-h-[268px]">
            <div class="flex flex-wrap flex-col items-center justify-center w-[70%]">
              <h2 class="font-medium mb-[10px] text-xl">Submit your quote request</h2>
              <div class="mb-[15px]">
                <p class="text-base text-gray-300 text-center">
                  Please review all the information you previously typed in the past steps, and if all is okay, submit your message to receive a project quote in 24 - 48 hours.
                </p>
              </div>
              <button type="submit" id="submit-btn">Submit</button>
            </div>
          </div>
        </section>
        <div class="mt-[20px] flex justify-between items-center">
          <button class="rounded-full px-[40px] py-[15px] border-blue-700 border hidden" id="prev-btn" type="button" phx-click="handle_step_backward_animation"><p class="text-blue-800 font-light"> Previous Step </p></button>
          <button class="rounded-full px-[40px] py-[15px] bg-blue-700 visible" id="next-btn" type="button" phx-click="handle_step_forward_animation"><p class="text-white">Next Step</p></button>
        </div>
      </div>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    second_section_blocks = [
      %{
        id: "block-development",
        text: "Development",
        icon: "Development"
      },
      %{
        id: "block-web-design",
        text: "Web Design",
        icon: "WebDesign"
      },
      %{
        id: "marketing",
        text: "Marketing",
        icon: "Group"
      },
      %{
        id: "other",
        text: "Other",
        icon: "Setting"
      }
    ]

    third_section_blocks = [
      %{
        text: "$5.000-$10.000",
        id: "small-amount"
      },
      %{
        text: "$10.000-$20.000",
        id: "medium-amount"
      },
      %{
        text: "$20.000-$50.000",
        id: "large-amount"
      },
      %{
        text: "$50.000 +",
        id: "max-amount"
      }
    ]

    {:ok,
     socket
     |> assign(show_animation: false)
     |> assign(current_section: 1)
     |> assign(sections: [1, 2, 3, 4])
     |> assign(second_section_blocks: second_section_blocks)
     |> assign(third_section_blocks: third_section_blocks)}
  end

  def handle_event("handle_step_forward_animation", _params, socket) do
    current_section = socket.assigns.current_section

    {:noreply,
     push_event(
       socket,
       "handle_step_forward_animation",
       %{current_section: current_section}
     )}
  end

  def handle_event("handle_step_backward_animation", _params, socket) do
    current_section = socket.assigns.current_section

    {:noreply,
     push_event(
       socket,
       "handle_step_backward_animation",
       %{current_section: current_section}
     )}
  end

  def handle_event("set_current_section", %{"current_section" => current_section}, socket) do
    {:noreply, assign(socket, current_section: current_section)}
  end
end
