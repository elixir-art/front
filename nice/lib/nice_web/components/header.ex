defmodule NiceWeb.Header do
  use NiceWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="flex justify-center">
    <nav class="pt-20 text-xl text-white">
      <.link href="/no_code" class="pr-11">Home</.link>
      <.link href="/feature" class="pr-11">Features</.link>
      <.link class="pr-11">Pricing</.link>
      <.link class="pr-11">Blog</.link>
      <.link class="pr-11">O</.link>
      <.link>En</.link>
    </nav>
    </div>
    """
  end
end
