defmodule MyCalendarWeb.Dashboard do
  use MyCalendarWeb, :live_view

  alias MyCalendarWeb.Dashboard
  alias MyCalendarWeb.IconComponent

  def render(assigns) do
    ~H"""
      <div class="flex justify-between items-center">
       <div class="flex justify-between gap-x-5">
       <IconComponent.render
        id="burger-menu"
        name="burger"
        width="24"
        height="24"
        stroke="none"

      />
       <IconComponent.render
        id="search"
        name="search"
        width="24"
        height="24"
        stroke="none"
      />

       </div>
       <div class="flex justify-between gap-x-4 items-center">
       <IconComponent.render
        id="notification"
        name="notification"
        width="24"
        height="24"
        fill="white"
        stroke="#B2B2B2"
      />
       <IconComponent.render
        id="quote"
        name="quote"
        width="16"
        height="16"
        viewBox="0 0 16 16"
        strokeWidth="0"
      />
      <img src={~p"/images/profile.png"} alt="photo" width="36" height="36" />
       <IconComponent.render
        id="arrow"
        name="arrow"
        width="24"
        height="24"
        fill="white"
        stroke="#B2B2B2"
      />
       </div>
      </div>

      <div class="container mx-auto bg-white">
      <h1 class="pt-5 text-xl font-medium py-5 xl:block">Dashboard</h1>
      <section class="py-2">
            <div class="flex flex-col gap-5 md:justify-center">
              <div class="flex flex-col gap-5 md:flex-row md:justify-center">
                <%= for card <- @first_cards do %>
                  <div class={"rounded-xl p-6 flex flex-col gap-5 #{card.background_color} md:w-1/3" }>
                    <h2 class="font-medium text-lg"><%= card.title %></h2>
                    <p class="text-xl font-medium	"><%= card.number %></p>
                    <p class={"text-lg whitespace-nowrap #{card.text_color}"}><%= card.description %></p>
                  </div>
                <% end %>
              </div>
              <div class="flex flex-col gap-5 md:flex-row md:justify-center">
                <%= for card <- @second_cards do %>
                  <div class="rounded-xl p-6 flex items-center justify-between border-2 border-gray-100 md:w-1/2 md:justify-center">
                      <div class="">
                        <h2 class="font-medium text-lg mb-5"><%= card.title %></h2>
                        <p class="text-2xl font-medium mb-6"><%= card.number %></p>
                        <div class="text-gray-600 text-sm">
                          <p class="mb-1"><%= "#{card.men} men" %></p>
                          <p class=""><%= "#{card.women} women" %></p>
                        </div>
                      </div>
                    <div>
                      <img
                        class="mb-5"
                        src={~p"/images/#{card.image}"}
                        alt="graph"
                        width="115"
                        height="78"
                      />
                      <p class="text-sm text-right bg-card_bg-peach p-1 rounded">
                        <%= "+#{card.persantage}% Past month" %>
                      </p>
                    </div>
                  </div>
                <% end %>
              </div>
            </div>
          </section>
      </div>
    """
  end

  def mount(_params, _session, socket) do
    first_cards = [
      %{
        title: "Available position",
        number: 24,
        description: "4 urgently needed",
        background_color: "bg-card_bg-peach",
        text_color: "text-accent_rose"
      },
      %{
        title: "Job open",
        number: 10,
        description: "4 active hiring",
        background_color: "bg-card_bg-blue",
        text_color: "text-accent_blue"
      },
      %{
        title: "New employees",
        number: 24,
        description: "4 department",
        background_color: "bg-card_bg-pink",
        text_color: "text-accent_pink"
      }
    ]

    second_cards = [
      %{
        title: "Total Employees",
        number: 216,
        men: "120",
        women: "96",
        image: "group_4.png",
        persantage: "2"
      },
      %{
        title: "Talent Request",
        number: 16,
        men: "6",
        women: "10",
        image: "group_5.png",
        persantage: "5"
      }
    ]

    {
      :ok,
      socket
      |> assign(first_cards: first_cards)
      |> assign(second_cards: second_cards)
    }
  end
end
