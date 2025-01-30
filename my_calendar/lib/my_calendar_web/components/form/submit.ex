defmodule MyCalendarWeb.Form.Submit do
  use Phoenix.LiveComponent

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    ~H"""
    <div class={"text-center px-12 #{assigns[:class]}"}>
      <img src="/images/submission.jpg" alt="photo" class="mx-auto mb-4" />

      <h2 class="text-lg font-bold mb-4">Submit your quote request</h2>
      <p class="text-gray-500 mb-6">
        Please review all the information you previously typed in the past steps, and if all is okay, submit your message to receive a project quote in 24 - 48 hours.
      </p>
      <button
        type="button"
        class="w-36 h-14 bg-formPrimary-200 text-white px-4 py-2 rounded-button"
        phx-click="submit_form"
      >
        Submit
      </button>
    </div>
    """
  end
end
