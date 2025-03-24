defmodule NiceWeb.NoCode do
  use NiceWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_banner_content()}
  end

  def handle_event(
        "banner_step_" <> direction,
        _params,
        %{assigns: %{banner_current_step: step}} = socket
      ) do

    new_step =
      case direction do
        "prev" -> step - 1
        "next" -> step + 1
      end
      |> IO.inspect()

    assign_step(socket, new_step)
  end

  defp assign_banner_content(socket) do
    banners = [
      %{
        id: 1,
        title: "Forget About Code",
        text:
          "Startup Framework gives you complete freedom over your creative process —you don’t have to think about any technical aspects. There are no limits and absolutely no coding."
      },
      %{
        id: 2,
        title: "Powerful Generator and Free Figma Sources",
        text:
          "Startup Framework contains components and complex blocks which can easily be integrated into almost any design. All of the components are made in the same style, and can easily be integrated into projects, allowing you to create hundreds of solutions."
      },
      %{
        id: 3,
        title: "Green Pulse",
        text:
          "A smart energy monitoring system that helps businesses and households optimize electricity consumption and reduce waste. AI-powered insights lead to lower costs and a greener planet."
      },
      %{
        id: 4,
        title: "Snap Chef",
        text:
          "An AI-driven meal planner that creates personalized recipes based on available ingredients in your fridge. Reduces food waste and makes cooking effortless."
      }
    ]

    assign(socket,
      banners: banners,
      banner_current_step: 1,
      current_banner: get_banner(banners, 1)
    )
  end

  defp get_banner(banners, current_step) do
    IO.inspect(current_step)
    Enum.find(banners, fn banner -> banner.id == current_step end) |>IO.inspect()
  end

  defp assign_step(%{assigns: %{banners: banners}} = socket, step) do
    valid_step = step_validate(step, get_max_step(banners))

    {:noreply,
     assign(socket,
       banner_current_step: valid_step,
       current_banner: get_banner(banners, valid_step)
     )}
  end

  defp step_validate(0, max_step) do
    max_step
  end

  defp step_validate(step, max_step) do
    cond do
      step > max_step -> 1
      step <= max_step -> step
    end
  end

  defp get_max_step(banners), do: Enum.max_by(banners, & &1.id).id
end
