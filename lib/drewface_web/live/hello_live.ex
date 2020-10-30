defmodule DrewfaceWeb.HelloLive do
  use DrewfaceWeb, :live_view
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    # mount will magically render hello_live.html.leex, I think
    {:ok, assign(socket, :hello, "Click Me!!")}
  end

  @impl true
  def handle_event(
        "circle_click",
        %{"circleid" => id, "circlecreate" => "true", "circlecolor" => color},
        socket
      ) do
    id = String.to_integer(id)
    next_id = id + 1
    Logger.debug("CREATE: #{inspect(id)}, #{inspect(color)}")

    {:noreply,
     update(socket, :circles, fn circles ->
       circles
       |> Map.put(id, %{:id => id, :color => change_color(color), :create => false})
       |> Map.put(next_id, %{:id => next_id, :color => change_color(), :create => true})
     end)}
  end

  @impl true
  def handle_event(
        "circle_click",
        %{"circleid" => id, "circlecreate" => "false", "circlecolor" => color},
        socket
      ) do
    id = String.to_integer(id)
    Logger.debug("NO CREATE #{inspect(id)}")

    {:noreply,
     update(socket, :circles, fn circles ->
       put_in(circles, [id, :color], change_color(color))
     end)}
  end

  # @impl true
  # def handle_event("circle1_click", _value, socket) do
  #   {:noreply, assign(socket, :circle1_color, change_color())}
  # end

  # @impl true
  # def handle_event("circle2_click", _value, socket) do
  #   {:noreply, assign(socket, :circle2_color, change_color())}
  # end

  # @impl true
  # def handle_event("circle3_click", _value, socket) do
  #   {:noreply, assign(socket, :circle3_color, change_color())}
  # end

  # @impl true
  # def handle_event("circle4_click", _value, socket) do
  #   {:noreply, assign(socket, :circle4_color, change_color())}
  # end

  # @impl true
  # def handle_event("circle5_click", _value, socket) do
  #   {:noreply, assign(socket, :circle5_color, change_color())}
  # end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Hello")
    |> assign(:circles, %{1 => %{:id => 1, :color => change_color(), :create => true}})
  end

  defp change_color() do
    Enum.random([
      "bg-orange-400",
      "bg-yellow",
      "bg-green-400",
      "bg-indigo-500",
      "bg-purple-500",
      "bg-pink",
      "bg-baby-blue",
      "bg-mint"
    ])
  end

  defp change_color(color) do
    [
      "bg-orange-400",
      "bg-yellow",
      "bg-green-400",
      "bg-indigo-500",
      "bg-purple-500",
      "bg-pink",
      "bg-baby-blue",
      "bg-mint"
    ]
    |> List.delete(color)
    |> Enum.random()
  end
end
