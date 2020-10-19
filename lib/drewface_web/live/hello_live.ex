defmodule DrewfaceWeb.HelloLive do
  use DrewfaceWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # mount will magically render hello_live.html.leex, I think
    {:ok, assign(socket, :hello, "I love Priya alot")}
  end

  @impl true
  def handle_event("circle_click", _value, socket) do
    {:noreply, assign(socket, :circle_color, change_color(socket.assigns.circle_color))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Hello")
    |> assign(:circle_color, "bg-baby-blue")
  end

  defp change_color("bg-pink") do
    "bg-baby-blue"
  end

  defp change_color("bg-baby-blue") do
    "bg-pink"
  end
end
