defmodule NiceWeb.Feature do
  use NiceWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
