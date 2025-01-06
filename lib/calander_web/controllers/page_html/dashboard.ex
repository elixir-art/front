defmodule CalanderWeb.PageHtml.Dashboard do
  use CalanderWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="md:grid md:grid-cols-[100px_1fr]">
      <div class="hidden md:block">
        <div class="flex items-center justify-center mb-[20px]">
          <h2 class="pt-[40px] px-[10px] font-semibold text-2xl">WeHR</h2>
        </div>
        <div>
          <div class="flex items-center justify-center mb-[10px]">
            <p class="text-gray-400 text-xs pb-2">MAIN MENU</p>
          </div>
          <div class="flex flex-col justify-center items-center gap-[30px] mb-[30px]">
            <%= for svg <- @svg_icons_sidebar do %>
              <svg class={@svg_size}>
                <use href={~p"/images/sprite.svg##{svg.svg_name}"}></use>
              </svg>
            <% end %>
          </div>
          <div class="flex items-center justify-center mb-[10px]">
            <p class="text-gray-400 text-xs pb-2">OTHER</p>
          </div>
          <div class="flex flex-col justify-center items-center gap-[30px]">
              <svg class={@svg_size}>
                <use href={~p"/images/sprite.svg#ic_support"}></use>
              </svg>
              <svg class={@svg_size}>
                <use href={~p"/images/sprite.svg#ic_settings"}></use>
              </svg>
          </div>
        </div>
      </div>
      <div>
        <header class="py-[10px]  border-b-2 border-gray-100">
          <div class="container mx-auto bg-white flex items-center justify-between md:max-w-full md:pl-[10px]">
            <div class={@flex_header}>
              <svg class={@svg_size}>
                <use href={~p"/images/sprite.svg#ic_burgermenu"}></use>
              </svg>
              <div class="md:hidden">
                <svg class={@svg_size}>
                  <use href={~p"/images/sprite.svg#search"}></use>
                </svg>
              </div>
              <div class="hidden md:block md:relative">
                <input class="w-[245px] border-b-2 border-gray-100 bg-gray-200" placeholder="Search" />
                <svg class={"absolute top-0 right-0 #{@svg_size}"}>
                  <use href={~p"/images/sprite.svg#search"}></use>
                </svg>
              </div>
            </div>
            <div class={@flex_header}>
              <svg class={@svg_size}>
                <use href={~p"/images/sprite.svg#ic_round-notifications"}></use>
              </svg>
              <svg class={@svg_size}>
                <use href={~p"/images/sprite.svg#bi_chat-left-dots-fill"}></use>
              </svg>
              <img src={~p"/images/profile.png"} alt="photo of user" width="36" height="36" />
              <svg class={@svg_size}>
                <use href={~p"/images/sprite.svg#arrow_down"}></use>
              </svg>
            </div>
          </div>
        </header>
        <div class="container mx-auto bg-white">
          <section class="py-[20px]">
            <h1 class="py-[10px] text-xl font-medium">Dashboard</h1>
            <ul class="flex flex-col gap-[20px]">
              <%= for card <- @first_cards do %>
                <li class={"rounded-xl p-6 flex flex-col gap-[20px] #{card.background_color}" }>
                  <h2 class="font-medium text-lg"><%= card.title %></h2>
                  <p class="text-2xl"><%= card.number %></p>
                  <p class={"text-lg #{card.text_color}"}><%= card.description %></p>
                </li>
              <% end %>
              <%= for card <- @second_cards do %>
                <li class="rounded-xl p-6 flex items-center justify-between border-2 border-gray-100">
                  <div>
                    <div class="mb-[32px]">
                      <h2 class="font-medium text-lg mb-[22px]"><%= card.title %></h2>
                      <p class="text-2xl"><%= card.number %></p>
                    </div>
                    <div class="text-gray-600 text-sm">
                      <p class="mb-[5px]"><%= "#{card.men} men" %></p>
                      <p class=""><%= "#{card.women} women" %></p>
                    </div>
                  </div>
                  <div>
                    <img
                      class="mb-[20px]"
                      src={~p"/images/#{card.image}"}
                      alt="graph"
                      width="115"
                      height="78"
                    />
                    <p class="text-sm text-right bg-red-50 p-[6px] rounded-md">
                      <%= "+#{card.persantage}% Past month" %>
                    </p>
                  </div>
                </li>
              <% end %>
            </ul>
          </section>
          <section class="">
            <div class="pt-[20px] pb-[10px] px-[24px] rounded-t-xl border-2 border-gray-100">
              <div class="flex justify-between items-center mb-[20px]">
                <h2 class="font-medium text-lg">Announcement</h2>
                <button
                  class="flex items-center gap-[5px] border-2 border-gray-100 p-1 rounded-md text-sm text-gray-400"
                  type="button"
                >
                  Today, 13 Sep 2021
                  <svg class="w-[18px] h-[18px]">
                    <use href={~p"/images/sprite.svg#arrow_down_light"}></use>
                  </svg>
                </button>
              </div>
              <ul class="flex flex-col gap-[10px]">
                <%= for card <- @third_cards do %>
                  <li class="rounded-xl p-6 flex flex-col gap-[16px] border-2 border-gray-100 bg-gray-50">
                    <h3 class="text-lg"><%= card.title %></h3>
                    <div class="flex justify-between items-center">
                      <p class="text-gray-600 text-sm"><%= card.date_time %></p>
                      <div class="flex gap-[6px]">
                        <svg class={"w-[24px] h-[24px] fill-[#{card.svg_color}]"}>
                          <use href={~p"/images/sprite.svg#bi_pin-angle-fill"}></use>
                        </svg>
                        <svg class="w-[24px] h-[24px]">
                          <use href={~p"/images/sprite.svg#carbon_overflow-menu-horizontal"}></use>
                        </svg>
                      </div>
                    </div>
                  </li>
                <% end %>
              </ul>
            </div>
            <button
              class="w-[100%] text-center py-[10px] rounded-b-lg border-gray-100 border-2 border-t-0 font-medium text-red-500"
              type="button"
            >
              See All Announcement
            </button>
          </section>
          <section class="py-[20px]">
            <div class="pl-[24px] pr-[48px] py-[24px] bg-blueHeader rounded-t-lg border-b-0">
              <h2 class="font-medium text-lg text-white">Recently Activity</h2>
            </div>
            <div class="pl-[24px] pr-[48px] bg-blueBody pb-[40px] rounded-b-lg border-t-0">
              <div class="flex flex-col gap-[5px] mb-[30px]">
                <p class="pt-[30px] text-gray-400 text-sm">10.40 AM, Fri 10 Sept 2021</p>
                <h3 class="font-medium text-lg text-white">You posted a new job</h3>
                <p class="text-lg text-white">
                  Kindly check the requirements and terms of work and make sure everything is right.
                </p>
              </div>
              <div class="">
                <h4 class="text-lg text-white mb-[20px]">Today you makes 12 Activity</h4>
                <button
                  class="bg-buttonRed text-white block px-[30px] py-[10px] font-medium rounded-md "
                  type="button"
                >
                  See All Activity
                </button>
              </div>
            </div>
          </section>
          <section class="py-[20px]">
            <div class="pt-[20px] pb-[10px] px-[24px] rounded-t-xl border-2 border-gray-100">
              <div class="flex justify-between items-center mb-[20px]">
                <h2 class="font-medium text-lg">Upcoming Schedule</h2>
                <button
                  class="flex items-center gap-[5px] border-2 border-gray-100 p-1 rounded-md text-sm text-gray-400"
                  type="button"
                >
                  Today, 13 Sep 2021
                  <svg class="w-[18px] h-[18px]">
                    <use href={~p"/images/sprite.svg#arrow_down_light"}></use>
                  </svg>
                </button>
              </div>
              <div class="">
                <p class="pt-[20px] text-gray-500 mb-[5px]">Priority</p>
                <div class="rounded-xl flex flex-col border-2 border-gray-100 bg-gray-50 p-2">
                  <h3 class="text-lg px-[10px] pt-[5px]">Review candidate applications</h3>
                  <div class="flex justify-between items-center px-[10px] pt-[5px]">
                    <p class="text-sm text-gray-500">5 minutes ago</p>
                    <svg class="w-[24px] h-[24px]">
                      <use href={~p"/images/sprite.svg#carbon_overflow-menu-horizontal"}></use>
                    </svg>
                  </div>
                </div>
                <p class="pt-[20px] mb-[10px]">Other</p>
                <ul class="flex flex-col gap-[16px]">
                  <%= for card <- @fourth_cards do %>
                    <li class="rounded-xl border-2 border-gray-100 bg-gray-50 p-2">
                      <h2 class="text-lg px-[10px] pt-[5px]"><%= card.title %></h2>
                      <div class="flex justify-between items-center px-[10px] pt-[5px]">
                        <p class="text-sm text-gray-500"><%= card.date_time %></p>
                        <svg class="w-[24px] h-[24px]">
                          <use href={~p"/images/sprite.svg#carbon_overflow-menu-horizontal"}></use>
                        </svg>
                      </div>
                    </li>
                  <% end %>
                </ul>
              </div>
            </div>
            <button
              class="w-[100%] text-center py-[10px] rounded-b-lg border-gray-100 border-2 border-t-0 font-medium text-red-500"
              type="button"
            >
              See All Announcement
            </button>
          </section>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    first_cards = [
      %{
        title: "Available position",
        number: 24,
        description: "4 urgently needed",
        background_color: "bg-red-50",
        text_color: "text-red-500"
      },
      %{
        title: "Job open",
        number: 10,
        description: "4 active hiring",
        background_color: "bg-blue-50",
        text_color: "text-blue-500"
      },
      %{
        title: "New employees",
        number: 24,
        description: "4 department",
        background_color: "bg-pink-100",
        text_color: "text-pink-500"
      }
    ]

    second_cards = [
      %{
        title: "Total Employees",
        number: 216,
        men: "120",
        women: "96",
        image: "image2.png",
        persantage: "2"
      },
      %{
        title: "Talent Request",
        number: 16,
        men: "6",
        women: "10",
        image: "image5.png",
        persantage: "5"
      }
    ]

    third_cards = [
      %{
        title: "Outing schedule for every department",
        date_time: "5 minutes ago",
        svg_color: "#686868"
      },
      %{
        title: "Meeting HR Department",
        date_time: "Yesterday, 12:30 PM",
        svg_color: "#B2B2B2"
      },
      %{
        title: "IT Department need two more talents for UX/UI Designer position",
        date_time: "Yesterday, 09:15 AM",
        svg_color: "#B2B2B2"
      }
    ]

    fourth_cards = [
      %{
        title: "Interview with candidates",
        date_time: "Today - 10.30 AM"
      },
      %{
        title: "Short meeting with product designer from IT Departement",
        date_time: "Today - 09.15 AM"
      }
    ]

    svg_icons_sidebar = [
      %{svg_name: "ic_dashboard"},
      %{svg_name: "ic_recruitment"},
      %{svg_name: "ic_calendar"},
      %{svg_name: "ic_employee"},
      %{svg_name: "ic_department"}
    ]

    {
      :ok,
      socket
      |> assign(svg_size: "w-6 h-6")
      |> assign(flex_header: "flex gap-[15px] items-center")
      |> assign(first_cards: first_cards)
      |> assign(second_cards: second_cards)
      |> assign(third_cards: third_cards)
      |> assign(fourth_cards: fourth_cards)
      |> assign(svg_icons_sidebar: svg_icons_sidebar)
    }
  end
end
