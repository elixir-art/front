defmodule FrontEndWeb.DashboardLive do
  use FrontEndWeb, :live_view
  import Iconify

  def mount(_params, _session, socket) do
    bubble_cards = [
      %{title: "Available Position", stat: 24, note: "4 Urgently needed", color: "orange"},
      %{title: "Job Open", stat: 10, note: "4 Active hiring", color: "blue"},
      %{title: "Total Employees", stat: 24, note: "4 Departments", color: "pink"}
    ]

    graph_cards = [
      %{title: "Total Employees", amount: 216, men: 120, women: 96, percent: "+2"},
      %{title: "Talent Request", amount: 16, men: 10, women: 6, percent: "+5"}
    ]

    announcement_cards = [
      %{title: "Outing schedule for every departement", time: "5 Minutes ago", pinned: true},
      %{title: "Meeting HR Department", time: "Yesterday, 12:30 PM", pinned: false},
      %{
        title: "YIT Department need two more talents for UX/UI Designer position",
        time: "Yesterday, 09:15 AM",
        pinned: false
      }
    ]

    schedule_cards = %{
      priority: [
        %{title: "Review candidate applications", time: "5 Minutes ago"}
      ],
      other: [
        %{title: "Interview with candidates", time: "Today - 10.30 AM"},
        %{
          title: "Short meeting with product designer from IT Departement",
          time: "Today - 09.15 AM"
        }
      ]
    }

    {:ok,
     socket
     |> assign(
       bubble_cards: bubble_cards,
       graph_cards: graph_cards,
       announcement_cards: announcement_cards,
       schedule_cards: schedule_cards
     )}
  end

  def color_bubble(assigns) do
    ~H"""
    <div class={"bg-#{@card.color}-100 pl-5 p-3 space-y-4 rounded-lg"}>
      <p class="font-medium">{@card.title}</p>
      <p class="text-3xl font-medium text-gray-800 mt-2">{@card.stat}</p>
      <p class={"font-roboto text-sm text-#{@card.color}-800 mt-1"}>{@card.note}</p>
    </div>
    """
  end

  def graph_bubble(assigns) do
    ~H"""
    <div class="flex justify-between p-5 space-x-10 border-gray-400 border-2 rounded-lg">
      <div>
        <h3 class="text-base font-medium mb-0.5">{@card.title}</h3>
        <p class="text-myxl font-medium text-gray-800 mt-5 mb-8">{@card.amount}</p>
        <div class="space-y-1">
          <p class="text-sm text-gray-500">{@card.men} Men</p>
          <p class="text-sm text-gray-500">{@card.women} Women</p>
        </div>
      </div>
      <div class="grid grid-cols-1 relative">
        <p class="text-orange-800 text-xxs font-rubik font-medium translate-y-[40%] translate-x-[40%]">
          {@card.percent}%
        </p>
        <image src="/images/graph.svg" class="justify-self-stretch" />
        <p class="font-roboto text-xs rounded-md bg-orange-100 ml-2 px-2.5 py-1 mt-4 text-center">
          {@card.percent}% Past month
        </p>
      </div>
    </div>
    """
  end

  slot :inner_block

  def list_bubble(assigns) do
    ~H"""
    <div class="border-gray-400 border-2 rounded-lg divide-y-2">
      <div class="p-5 space-y-4">
        <div class="flex justify-between">
          <h3 class="text-base font-medium mb-0.5">{@title}</h3>
          <div class="flex justify-between py-1 border-gray-50 border-2 rounded-md">
            <p class="ml-1.5 text-xxs text-gray-500 font-roboto">{@time}</p>
            <.iconify icon="solar:alt-arrow-down-line-duotone" class="mx-2 h-4 w-4 text-gray-300" />
          </div>
        </div>
        {render_slot(@inner_block)}
      </div>
      <p class="text-orange-800 text-sm font-medium text-center p-2.5">{@bottom_text}</p>
    </div>
    """
  end

  def gray_bubble(assigns) do
    ~H"""
    <div class="bg-gray-100 border-2 rounded-md space-y-[5px] py-2">
      <p class="pl-3.5 mr-2.5 text-sm">{@card.title}</p>
      <div class="flex px-3.5 justify-between">
        <p class="text-xxs">{@card.time}</p>
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end
end
