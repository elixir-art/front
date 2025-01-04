defmodule CalanderWeb.PageHtml.Dashboard do
  use CalanderWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="container bg-white">
      <header class="flex py-[10px] items-center justify-between border-b-2 border-gray-100">
        <div class={@flex_header}>
          <svg class={@svg_size}>
            <use href={~p"/images/sprite.svg#ic_burgermenu"}></use>
          </svg>
          <svg class={@svg_size}>
            <use href={~p"/images/sprite.svg#search"}></use>
          </svg>
        </div>
        <div class={@flex_header}>
          <svg class={@svg_size}>
            <use href={~p"/images/sprite.svg#ic_round-notifications"}></use>
          </svg>
          <svg class={@svg_size}>
            <use href={~p"/images/sprite.svg#bi_chat-left-dots-fill"}></use>
          </svg>
          <img src={~p"/images/profile.png"} alt="photo of user" width="36" height="36"/>
          <svg class={@svg_size}>
            <use href={~p"/images/sprite.svg#arrow_down"}></use>
          </svg>
        </div>
      </header>
      <section class="py-[20px]">
        <h1 class="py-[10px] text-xl font-medium"> Dashboard </h1>
        <ul class="flex flex-col gap-[20px]">
        <%= for card <- @first_cards do %>
         <li class={"rounded-xl p-6 flex flex-col gap-[20px] #{card.background_color}" }>
          <h2 class="font-medium text-lg"><%=card.title%></h2>
          <p class="text-2xl"><%=card.number%></p>
          <p class={"text-lg #{card.text_color}"}><%=card.description%></p>
        </li>
        <% end %>
        </ul>
      </section>
      <section class="py-[20px]"> </section>
      <section class="py-[20px]"> </section>
      <section class="py-[20px]"> </section>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    first_cards = [%{title: "Available position", number: 24, description: "4 urgently needed", background_color: "bg-red-50", text_color: "text-red-500"},
    %{title: "Job open", number: 10, description: "4 active hiring", background_color: "bg-blue-50", text_color: "text-blue-500"},
    %{title: "New employees", number: 24, description: "4 department", background_color: "bg-pink-100", text_color: "text-pink-500"}]
    {
      :ok,
      socket
      |> assign(svg_size: "w-6 h-6")
      |> assign(flex_header: "flex gap-[15px] items-center")
      |> assign(first_cards: first_cards)
    }
  end
end
