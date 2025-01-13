defmodule MyCalendarWeb.Dashboard do
  use MyCalendarWeb, :live_view

  alias MyCalendarWeb.IconComponent

  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="bg-gray-50 hidden md:block">
        <p class="px-4 pt-10 pb-5 font-semibold text-center text-xl lg:text-4xl lg:px-16 lg:pt-8">
          WeHR
        </p>
        <div class="pt-3 flex flex-col items-center lg:items-start lg:pl-8">
          <p class="text-center lg:text-start mb-5 font-roboto font-medium opacity-50 text-gray2 text-xxs">
            MAIN MENU
          </p>
          <div class="flex items-center">
            <IconComponent.render name="dashboard" fill="#FF5151" />
            <p class="hidden lg:block font-medium text-active ml-6">Dashboard</p>
          </div>
          <div class="flex items-center my-9">
            <IconComponent.render name="recruitment" />
            <p class="hidden lg:block ml-6 text-primarySubtitle">Recruitment</p>
          </div>
          <div class="flex items-center">
            <IconComponent.render name="calendar" />
            <p class="hidden lg:block ml-6 text-primarySubtitle">Schedule</p>
          </div>
          <div class="flex items-center my-9">
            <IconComponent.render name="employee" />
            <p class="hidden lg:block ml-6 text-primarySubtitle">Employee</p>
          </div>
          <div class="flex items-center">
            <IconComponent.render name="department" />
            <p class="hidden lg:block ml-6 text-primarySubtitle">Department</p>
          </div>
          <p class="text-center mt-10 font-roboto font-medium opacity-50 text-gray2 text-xxs">
            OTHER
          </p>
          <div class="flex items-center mt-5 mb-9">
            <IconComponent.render name="support" />
            <p class="hidden lg:block ml-6 text-primarySubtitle">Support</p>
          </div>
          <div class="flex items-center">
            <IconComponent.render name="settings" />
            <p class="hidden lg:block ml-6 text-primarySubtitle">Settings</p>
          </div>
        </div>
      </div>

      <div>
        <div class="container mx-auto py-2 px-5 md:px-14 lg:py-5">
          <div class="flex justify-between items-center">
            <div class="flex justify-between gap-x-5 items-center">
              <IconComponent.render id="burger-menu" name="burger" class="lg:hidden" />
              <div class="relative">
                <input
                  type="text"
                  placeholder="Search"
                  class="hidden md:inline-block md:w-60 lg:w-80 bg-gray-50 border-gray-200 rounded-lg text-sm text-grayInput"
                />
                <IconComponent.render
                  id="search"
                  name="search"
                  class="absolute top-1/2 -translate-y-1/2 left-0 md:left-48 lg:left-72"
                />
              </div>
            </div>
            <div class="flex justify-between gap-x-4 items-center md:gap-x-8">
              <IconComponent.render
                id="notification"
                name="notification"
                fill="#B2B2B2"
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
              <div class="flex gap-1.5 items-center">
                <img src={~p"/images/profile.png"} alt="photo" width="36" height="36" />
                <span class="hidden lg:block ml-2 text-100 medium">Admira John</span>
                <IconComponent.render id="arrow" name="arrow" fill="white" stroke="#B2B2B2" />
              </div>
            </div>
          </div>
        </div>

        <div class='w-full h-px bg-card_bg-gray3'></div>

        <div class="container mx-auto bg-white px-5 pb-6 md:px-14">
          <h1 class="pt-5 text-xl font-medium py-5 xl:block">Dashboard</h1>
          <div class="lg:flex lg:justify-between lg:gap-6">
            <div class="">
              <section class="py-2">
                <div class="flex flex-col gap-5 md:justify-center">
                  <div class="flex flex-col gap-5 md:flex-row md:justify-center md:items-stretch">
                    <%= for card <- @first_cards do %>
                      <div class={"rounded-xl p-6 flex flex-col flex-1 gap-5 #{card.background_color} md:w-1/3" }>
                        <h2 class="font-medium text-lg"><%= card.title %></h2>
                        <p class="text-xl font-medium	"><%= card.number %></p>
                        <p class={"text-lg whitespace-nowrap #{card.text_color}"}>
                          <%= card.description %>
                        </p>
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

              <div>
                <div class="rounded-t-xl border-2 border-gray-100 rounded-lg mt-4">
                  <div class="flex justify-between items-center pt-4 px-5">
                    <h2 class="font-medium text-lg">Announcement</h2>
                    <button
                      class="flex items-center gap-1 border-2 border-gray-100 p-3 rounded-md text-sm text-gray-400"
                      type="button"
                    >
                      Today, 13 Sep 2021
                    </button>
                  </div>
                  <ul class="flex flex-col gap-3 px-5 pt-4 pb-2">
                    <%= for card <- @third_cards do %>
                      <li class="rounded-xl p-6 flex flex-col gap-3 border-2 border-gray-100 bg-gray-50">
                        <h3 class="text-lg"><%= card.title %></h3>
                        <div class="flex justify-between items-center">
                          <p class="text-gray-600 text-sm"><%= card.date_time %></p>
                          <div class="flex gap-3">
                            <IconComponent.render id="staple" name="staple" fill={card.fill} />
                            <IconComponent.render id="overflow" name="overflow" />
                          </div>
                        </div>
                      </li>
                    <% end %>
                  </ul>
                  <button
                    class="w-full text-center p-3 border-t-2 border-gray-100 font-medium text-lg text-mainColor"
                    type="button"
                  >
                    See All Announcement
                  </button>
                </div>
              </div>
            </div>

            <section class="grid grid-cols-1 md:grid-cols-[1.5fr_2fr] md:gap-4 lg:flex lg:flex-col">
              <div class="rounded-lg overflow-hidden mt-5">
                <div class="bg-card_bg-violet1">
                  <h3 class="text-white text-100 font-poppins font-medium py-4 ml-5 mr-2.5">
                    Recent Activity
                  </h3>
                </div>
                <div class="flex-cols justify-items-start bg-card_bg-violet2 text-white pl-5 pb-8 pr-10 rounded-b-lg">
                  <p class="font-roboto text-xs opacity-60 pt-3">10.40 AM, Fri 10 Sept 2021</p>
                  <p class="text-100 font-medium py-2">You Posted a New Job</p>
                  <p class="text-sm opacity-80 mb-7">
                    Kindly check the requirements and terms of work and make sure everything is
                    right.
                  </p>
                  <p class="text-base font-roboto mb-7">Today you made 12 Activities</p>
                  <button class="w-36 bg-orange rounded-md font-poppins font-medium capitalize text-sm py-2.5 px-4">
                    See all activity
                  </button>
                </div>
              </div>

              <div class="rounded-lg border-2 border-gray-100 mt-5">
                <div class="flex justify-between items-center pt-4 px-5">
                  <h2 class="font-medium text-lg">Upcoming Schedule</h2>
                  <button
                    class="flex items-center gap-1 border-2 border-gray-100 p-3 rounded-md text-sm text-gray-400"
                    type="button"
                  >
                    Today, 13 Sep 2021
                  </button>
                </div>
                <div class="px-5 pt-4 pb-2">
                  <p class="text-gray-500 mb-1">Priority</p>
                  <div class="rounded-xl flex flex-col border-2 border-gray-100 bg-gray-50 p-2">
                    <h3 class="text-lg px-2 pt-1">Review candidate applications</h3>
                    <div class="flex justify-between items-center px-2 pt-1">
                      <p class="text-sm text-gray-500">5 minutes ago</p>
                      <IconComponent.render id="overflow" name="overflow" />
                    </div>
                  </div>
                  <p class="pt-5 mb-2">Other</p>
                  <ul class="flex flex-col gap-4">
                    <%= for card <- @fourth_cards do %>
                      <li class={"rounded-xl border-2 border-gray-100 bg-gray-50 p-2 md:#{card.display}"}>
                        <h2 class="text-lg px-2 pt-1"><%= card.title %></h2>
                        <div class="flex justify-between items-center px-2 pt-1">
                          <p class="text-sm text-gray-500"><%= card.date_time %></p>
                          <IconComponent.render id="overflow" name="overflow" />
                        </div>
                      </li>
                    <% end %>
                  </ul>
                </div>
                <button
                  class="w-full text-center font-medium text-lg text-mainColor p-3 border-t-2 border-gray-100"
                  type="button"
                >
                  See All Announcement
                </button>
              </div>
            </section>
          </div>
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

    third_cards = [
      %{
        title: "Outing schedule for every department",
        date_time: "5 minutes ago",
        fill: "#686868"
      },
      %{
        title: "Meeting HR Department",
        date_time: "Yesterday, 12:30 PM",
        fill: "#B2B2B2"
      },
      %{
        title: "IT Department need two more talents for UX/UI Designer position",
        date_time: "Yesterday, 09:15 AM",
        fill: "#B2B2B2"
      }
    ]

    fourth_cards = [
      %{
        title: "Interview with candidates",
        date_time: "Today - 10.30 AM",
        display: "block"
      },
      %{
        title: "Short meeting with product designer from IT Departement",
        date_time: "Today - 09.15 AM",
        display: "hidden"
      }
    ]

    {
      :ok,
      socket
      |> assign(first_cards: first_cards)
      |> assign(second_cards: second_cards)
      |> assign(third_cards: third_cards)
      |> assign(fourth_cards: fourth_cards)
    }
  end
end
