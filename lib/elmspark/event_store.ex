defmodule Elmspark.EventStore do
  use GenServer


  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def store_events(events) do
    GenServer.cast(__MODULE__, {:store_events, events})
  end

  def get_events() do
    GenServer.call(__MODULE__, :get_events)
  end

  # Server

  def init([]) do
    {:ok, []}
  end

  def handle_cast({:store_events, events}, state) do
    {:noreply, events ++ state}
  end

  def handle_call(:get_events, _from, state) do
    {:reply, state, state}
  end
end
