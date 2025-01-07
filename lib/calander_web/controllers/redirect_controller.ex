defmodule CalanderWeb.RedirectController do
  use CalanderWeb, :controller

  def redirect_to_calendar(conn, _params) do
    redirect(conn, to: "/calendar")
  end
end
