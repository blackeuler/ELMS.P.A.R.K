defmodule Elmspark.EventStore.Events do
  alias Elmspark.EventStore.Event
  alias Elmspark.EventStore

  def new(%{aggregate_id: aggregate_id, name: name, data: data}, to_time \\ &DateTime.utc_now/0) do
    %Event{
      aggregate_id: aggregate_id,
      name: name,
      data: data,
      inserted_at: to_time.()
    }
  end

  def insert(event) do
    EventStore.store_events([event])
  end

  def insert_many(events) do
    EventStore.store_events(events)
  end

  def get_all() do
    EventStore.get_events()
  end

  def filter(f) do
    EventStore.get_events_by(f)
  end
end
