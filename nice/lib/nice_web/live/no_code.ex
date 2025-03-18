defmodule NiceWeb.NoCode do
  use NiceWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
