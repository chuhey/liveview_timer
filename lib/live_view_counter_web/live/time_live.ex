defmodule LiveViewCounterWeb.TimeLive do
  use Phoenix.LiveView
  alias LiveViewCounterWeb.CounterView

  def render(assigns) do
    ~L"""
    <div>
    <H1>time is : <%= @time %></h1>
    <button phx-click="start">start</button>
    <button phx-click="stop">stop</button>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, t} = Time.new(0, 0, 0, 0)
    socket = assign(socket, status: :stop)
    {:ok, assign(socket, time: Time.to_string(t))}
  end

  def handle_event("start", _, %{assigns: %{status: :start}} = socket), do: {:noreply, socket}
  def handle_event("start", _, socket) do
    socket = update(socket, :status, fn _ -> :start end)

    socket =
      if Map.has_key?(socket.assigns, "datetime") do
        socket
      else
        assign(socket, datetime: NaiveDateTime.utc_now())
      end

    if connected?(socket) do
      Process.send_after(self(), :count, 10)
    end

    {:noreply, socket}
  end

  def handle_event("stop", _, %{assigns: %{status: :stop}} = socket), do: {:noreply, socket}
  def handle_event("stop", _, socket) do
    socket = update(socket, :status, fn _ -> :stop end)

    t = count_time(socket.assigns.datetime, NaiveDateTime.utc_now())
    {:noreply, update(socket, :time, fn _ -> Time.to_string(t) end)}
  end

  def handle_info(:count, %{assigns: %{status: :stop}} = socket), do: {:noreply, socket}
  def handle_info(:count, socket) do
    if connected?(socket) do
      Process.send_after(self(), :count, 10)
    end

    t = count_time(socket.assigns.datetime, NaiveDateTime.utc_now())
    {:noreply, update(socket, :time, fn _ -> Time.to_string(t) end)}
  end

  defp count_time(t_start, t_end) do
    d = NaiveDateTime.diff(t_end, t_start, :microsecond)
    {:ok, t} = Time.new(0, 0, 0, 0)
    Time.add(t, d, :microsecond)
  end
end
