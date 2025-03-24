defmodule NiceWeb.ContentBanner do
  use NiceWeb, :live_component

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end
  
  def render(assigns) do
    ~H"""
    <div class="banner">
      <.button phx-click="banner_step_prev">
      A
      </.button>
      <h2><%= @current_banner.title%></h2>
      <p><%= @current_banner.text%></p>
    </div>
    """
  end
end
